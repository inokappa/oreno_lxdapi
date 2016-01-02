require "oreno_lxdapi/version"
require "net_http_unix"
require "json"
require "logger"

module OrenoLxdapi
  class Client

    def initialize(uri, image_name, container_name)
      @log = Logger.new(STDOUT)
      @uri = uri
      @image_name = image_name
      @container_name = container_name
    end

    def client
      NetX::HTTPUnix.new(@uri)
    end
    
    def list_containers
      req = Net::HTTP::Get.new("/1.0/containers")
      resp = client.request(req)
      return resp.body
    end

    def config_container(opts={})
    end
    
    def create_container(opts={})
      options = {
        :architecture => 2,
        :profiles => ["default"],
        :ephemeral => true,
        :limits_cpu => "1",
      }

      options.merge!(opts)

      req = Net::HTTP::Post.new("/1.0/containers")
      req["Content-Type"] = "application/json"
      payload = {
        "name" => @container_name,
        "architecture" => options[:architecture].to_i,
        "profiles" =>  options[:profiles],
        "ephemeral" => options[:ephemeral],
        "config" => {
          "limits.cpu" => options[:limits_cpu]
        },
        "source" =>  {
          "type" => "image",
          "alias" => @image_name
        }
      }
      req.body = payload.to_json

      resp = client.request(req)
      return resp.body
    end

    def delete_container
      @log.info("Deleting Container...")
      req = Net::HTTP::Delete.new("/1.0/containers/#{@container_name}")
      resp = client.request(req)
      return resp.body
    end
    
    def describe_container
      req = Net::HTTP::Get.new("/1.0/containers/#{@container_name}")
      resp = client.request(req)
      json = JSON.parse(resp.body)

      if json['metadata']
        return json['metadata']
      else
        @log.warn("Failed to get metadata.")
      end

    end
    
    def check_container_status
      req = Net::HTTP::Get.new("/1.0/containers/#{@container_name}/state")
      resp = client.request(req)
      json = JSON.parse(resp.body)

      status = ""
      ipv4 = ""
      if json['metadata']
        status = json['metadata']['status']
        unless json['metadata']['ips'] == nil
          json['metadata']['ips'].each { |ip| ipv4 = ip['address'] if ip['interface'] == "eth0"}
          return status, ipv4
        else
          return status
        end
      end
    
    end

    def state_container(action, opts={})
      options = {
        :timeout => 30,
        :force => true
      }

      options.merge!(opts)

      req = Net::HTTP::Put.new("/1.0/containers/#{@container_name}/state")
      req["Content-Type"] = "application/json"
      payload = {
        "action" => action,
        "timeout" => options[:timeout],
        "force" => options[:force]
      }
      req.body = payload.to_json
      resp = client.request(req)

      if action == "start"
        loop do
          @log.info("Starting Container...")
          status = check_container_status
          if status.length == 2 && status[1] != ""
            break
          end

          sleep 3
        end
        return resp.body
      elsif action == "stop"
        @log.info("Stopping Container...")
        return resp.body
      else
        @log.warn("Invalid argument.")
      end 

    end

    def file_upload(src, dst)
      req = Net::HTTP::Post.new("/1.0/containers/#{@container_name}/files?path=#{dst}")
      req["X-LXD-uid"] = "0"
      req["X-LXD-gid"] = "0"
      req["X-LXD-mode"] = "700"
      req["Content-Type"] = "multipart/form-data"

      resp = ""
      File.open(src, 'rb') do |f|
        req.body_stream = f
        req["Content-Length"] = f.size
        resp = client.request(req)
      end
     
      return resp.body
    end

    def create_exec(command)
    #  commands = command.split(" ")
    #  req = Net::HTTP::Post.new("/1.0/containers/#{@container_name}/exec")
    #  req["Content-Type"] = "application/json"
    #  payload = {
    #    "command" =>  commands,
    #    "environment" => {
    #      "HOME" => "/root",
    #      "TERM" => "screen",
    #      "USER" => "root",
    #    },
    #    "wait-for-websocket" => true,
    #    "interactive" => true,
    #  }
    #  req.body = payload.to_json
    # 
    #  resp = client.request(req)
    #  json = JSON.parse(resp.body)

    #  operation_id = ""
    #  secret = ""

    #  if json['metadata']
    #    operation_id = json['metadata']['id']
    #    unless json['metadata']['metadata'] == nil
    #      secret = json['metadata']['metadata']['fds']['0']
    #      return operation_id, secret
    #    else
    #      return operation_id
    #    end
    #  end

    end

    def run_exec(operation_id, secret)
      # run_lxc_exec
    end

    def run_lxc_exec(command)
      lxc_exec = "lxc exec #{@container_name} -- "
      run_command = lxc_exec + command
      status = system(run_command)
      return status
    end

    #def wait_operation(operation_id)
    #  req = Net::HTTP::Get.new("/1.0/operations/#{operation_id}/wait")
    #  resp = client.request(req)
    #  return resp.body
    #end

  end
end

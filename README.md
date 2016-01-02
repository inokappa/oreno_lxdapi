# Oreno LXD API Client for Ruby
[![Build Status](https://travis-ci.org/inokappa/oreno_lxdapi.svg)](https://travis-ci.org/inokappa/oreno_lxdapi)

## Reference

- [LXD REST API](https://github.com/lxc/lxd/blob/master/specs/rest-api.md)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oreno_lxdapi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oreno_lxdapi

## Usage

### sample script and output

- sample

```ruby
#!/usr/bin/env ruby                                                                                                                         

require 'oreno_lxdapi'

c = OrenoLxdapi::Client.new(
  "unix:///var/lib/lxd/unix.socket",
  "oreno-ubuntu-image",
  "test01"
)
p c.class

puts "=== create_container"
p c.create_container(
  { 
    :architecture => "2",
    :limits_cpu => "1",
    :ephemeral => false
  }
)
sleep 5

puts "=== run_container"
p c.state_container("start", :timeout => 50)

puts "=== file_upload"
p c.file_upload("sample.txt", "/tmp/sample.txt")

puts "=== run_lxc_exec"
c.run_lxc_exec("pwd")
c.run_lxc_exec("ls -l /tmp/sample.txt")

puts "== describe_container"
metadata = c.describe_container
data = []
data << metadata['status']['status']
data << metadata['ephemeral']
data << metadata['status']['ips'].each { |ip| p ip['address'] if ip['interface'] == "eth0"}
p data

puts "=== stop_container"
p c.state_container("stop", :timeout => 50)
sleep 5
p c.delete_container
```

- output

```sh
OrenoLxdapi::Client

=== create_container
"{\"type\":\"async\",\"status\":\"OK\",\"status_code\":100,\"metadata\":{\"id\":\"e01bac0f-30f4-4dae-91b5-f7fd7e7ea926\",\"class\":\"task\",\"created_at\":\"2016-01-02T19:51:40.161118734+09:00\",\"updated_at\":\"2016-01-02T19:51:40.161118734+09:00\",\"status\":\"Running\",\"status_code\":103,\"resources\":{\"containers\":[\"/1.0/containers/test01\"]},\"metadata\":null,\"may_cancel\":false,\"err\":\"\"},\"operation\":\"/1.0/operations/e01bac0f-30f4-4dae-91b5-f7fd7e7ea926\"}\n"

=== run_container
I, [2016-01-02T19:51:45.177958 #22904]  INFO -- : Starting Container...
I, [2016-01-02T19:51:48.242125 #22904]  INFO -- : Starting Container...
"{\"type\":\"async\",\"status\":\"OK\",\"status_code\":100,\"metadata\":{\"id\":\"03e75986-9732-41c1-8ef3-71ad2dcc1112\",\"class\":\"task\",\"created_at\":\"2016-01-02T19:51:45.172238776+09:00\",\"updated_at\":\"2016-01-02T19:51:45.172238776+09:00\",\"status\":\"Running\",\"status_code\":103,\"resources\":{\"containers\":[\"/1.0/containers/test01\"]},\"metadata\":null,\"may_cancel\":false,\"err\":\"\"},\"operation\":\"/1.0/operations/03e75986-9732-41c1-8ef3-71ad2dcc1112\"}\n"

=== file_upload
"{\"type\":\"sync\",\"status\":\"Success\",\"status_code\":200,\"metadata\":{},\"operation\":\"\"}\n"

=== run_lxc_exec
/root
--w-r-xr-- 1 root root 0 Jan  2 10:51 /tmp/sample.txt

== describe_container
"xx.x.x.205"
["Running", false, [{"interface"=>"eth0", "protocol"=>"IPV4", "address"=>"xx.x.x.205", "host_veth"=>"vethVIDOBX"}, {"interface"=>"lo", "protocol"=>"IPV4", "address"=>"127.0.0.1", "host_veth"=>""}, {"interface"=>"lo", "protocol"=>"IPV6", "address"=>"::1", "host_veth"=>""}]]

=== stop_container
I, [2016-01-02T19:51:48.563168 #22904]  INFO -- : Stopping Container...
"{\"type\":\"async\",\"status\":\"OK\",\"status_code\":100,\"metadata\":{\"id\":\"b244aead-bf3f-4e2a-9ad4-0168fa64d45b\",\"class\":\"task\",\"created_at\":\"2016-01-02T19:51:48.559000682+09:00\",\"updated_at\":\"2016-01-02T19:51:48.559000682+09:00\",\"status\":\"Running\",\"status_code\":103,\"resources\":{\"containers\":[\"/1.0/containers/test01\"]},\"metadata\":null,\"may_cancel\":false,\"err\":\"\"},\"operation\":\"/1.0/operations/b244aead-bf3f-4e2a-9ad4-0168fa64d45b\"}\n"
I, [2016-01-02T19:51:53.563774 #22904]  INFO -- : Deleting Container...
"{\"type\":\"async\",\"status\":\"OK\",\"status_code\":100,\"metadata\":{\"id\":\"a423baec-656e-49d3-8ab5-270cf7f11492\",\"class\":\"task\",\"created_at\":\"2016-01-02T19:51:53.577319191+09:00\",\"updated_at\":\"2016-01-02T19:51:53.577319191+09:00\",\"status\":\"Running\",\"status_code\":103,\"resources\":{\"containers\":[\"/1.0/containers/test01\"]},\"metadata\":null,\"may_cancel\":false,\"err\":\"\"},\"operation\":\"/1.0/operations/a423baec-656e-49d3-8ab5-270cf7f11492\"}\n"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/oreno_lxdapi.


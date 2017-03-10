require 'spec_helper'
require 'oreno_lxdapi'

describe OrenoLxdapi do
  before do
    # @container = OrenoLxdapi::Client.new('unix:///var/lib/lxd/unix.socket',
    #                                      'oreno-ubuntu-image', 'test01')
    @container = OrenoLxdapi::Client.new('/path/to/uri',
                                         'test-image01', 'test01')
  end

  it 'Has a version number' do
    expect(OrenoLxdapi::VERSION).not_to be nil
  end

  it 'Detect a oreno_lxdapi client' do
    expect(@container.client).to be_a_kind_of(Object)
  end

  it 'List containers(#list_containers)' do
    containers_list = [{ 'name' => 'foo' }]
    allow(@container).to receive(:list_containers).and_return(containers_list)
    response = @container.list_containers
    expect(response).to eq containers_list
  end

  it 'Create config(#config_container)' do
  end

  it 'Create container(#create_container)' do
    res = '{"type":"async","status":"OK","status_code":100,"metadata":'\
          '{"id":"xxxxx-xxxxx-xxxxx-xxxxx","class":"task","created_at":'\
          '"2016-01-02T12:38:17.743488578+09:00","updated_at":'\
          '"2016-01-02T12:38:17.743488578+09:00","status":"Running",'\
          '"status_code":103,"resources":{"containers":'\
          '["/1.0/containers/test01"]},"metadata":null,"may_cancel":false,'\
          '"err":""},"operation":"/1.0/operations/xxxxx-xxxxx-xxxxx-xxxxx"}'
    allow(@container).to receive(:create_container).and_return(res)
    response = @container.create_container
    expect(response).to eq res
  end

  it 'Delete container(#delete_container)' do
    res = '{"type":"async","status":"OK","status_code":100,"metadata":'\
          '{"id":"xxxxx-xxxxx-xxxxx-xxxxx","class":"task","created_at":'\
          '"2016-01-02T12:38:17.743488578+09:00","updated_at":'\
          '"2016-01-02T12:38:17.743488578+09:00","status":"Running",'\
          '"status_code":103,"resources":{"containers":'\
          '["/1.0/containers/test01"]},"metadata":null,"may_cancel":false,'\
          '"err":""},"operation":"/1.0/operations/xxxxx-xxxxx-xxxxx-xxxxx"}'
    allow(@container).to receive(:delete_container).and_return(res)
    response = @container.delete_container
    expect(response).to eq res
  end

  it 'Describe container(#describe_container)' do
    res = [{ 'name' => 'foo' }]
    allow(@container).to receive(:describe_container).and_return(res)
    response = @container.describe_container
    expect(response).to eq res
  end

  it 'Check container status(#check_container_status)' do
    res = [{ 'name' => 'foo' }]
    allow(@container).to receive(:check_container_status).and_return(res)
    response = @container.check_container_status
    expect(response).to eq res
  end

  it 'Start container(#state_container)' do
    res = '{"type":"async","status":"OK","status_code":100,"metadata":'\
          '{"id":"xxxxx-xxxxx-xxxxx-xxxxx","class":"task","created_at":'\
          '"2016-01-02T16:21:59.523150482+09:00","updated_at":'\
          '"2016-01-02T16:21:59.523150482+09:00","status":"Running",'\
          '"status_code":103,"resources":{"containers":'\
          '["/1.0/containers/test01"]},"metadata":null,"may_cancel":false,'\
          '"err":""},"operation":"/1.0/operations/xxxxx-xxxxx-xxxxx-xxxxx"}'
    allow(@container).to receive(:state_container).with('start').and_return(res)
    response = @container.state_container('start')
    expect(response).to eq res
  end

  it 'Stop container(#state_container)' do
    res = '{"type":"async","status":"OK","status_code":100,"metadata":'\
          '{"id":"xxxxx-xxxxx-xxxxx-xxxxx","class":"task","created_at":'\
          '"2016-01-02T16:22:02.897838648+09:00","updated_at":'\
          '"2016-01-02T16:22:02.897838648+09:00","status":"Running",'\
          '"status_code":103,"resources":{"containers":'\
          '["/1.0/containers/test01"]},"metadata":null,"may_cancel":false,'\
          '"err":""},"operation":"/1.0/operations/xxxxx-xxxxx-xxxxx-xxxxx"}'
    allow(@container).to receive(:state_container).with('stop').and_return(res)
    response = @container.state_container('stop')
    expect(response).to eq res
  end

  it 'File upload(#file_upload)' do
    res = '{"type":"sync","status":"Success","status_code":200,"metadata":'\
          '{},"operation":""}'
    allow(@container).to \
      receive(:file_upload).with('src', 'dst').and_return(res)
    response = @container.file_upload('src', 'dst')
    expect(response).to eq res
  end
end

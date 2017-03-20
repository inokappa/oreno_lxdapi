require 'spec_helper'
require 'oreno_lxdapi'

describe OrenoLxdapi do
  before do
    @container = OrenoLxdapi::Client.new('/path/to/uri',
                                         'test-image01', 'test01')
  end

  it 'List containers(#list_containers)' do
    containers_list = [{ 'name' => 'foo' }]
    allow(@container).to receive(:list_containers).and_return(containers_list)
    response = @container.list_containers
    expect(response).to eq containers_list
  end
end

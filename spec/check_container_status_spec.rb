require 'spec_helper'
require 'oreno_lxdapi'

describe OrenoLxdapi do
  before do
    @container = OrenoLxdapi::Client.new('/path/to/uri',
                                         'test-image01', 'test01')
  end

  it 'Check container status(#check_container_status)' do
    res = [{ 'name' => 'foo' }]
    allow(@container).to receive(:check_container_status).and_return(res)
    response = @container.check_container_status
    expect(response).to eq res
  end
end

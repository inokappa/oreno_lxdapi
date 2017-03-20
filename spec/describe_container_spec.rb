require 'spec_helper'
require 'oreno_lxdapi'

describe OrenoLxdapi do
  before do
    @container = OrenoLxdapi::Client.new('/path/to/uri',
                                         'test-image01', 'test01')
  end

  it 'Describe container(#describe_container)' do
    res = [{ 'name' => 'foo' }]
    allow(@container).to receive(:describe_container).and_return(res)
    response = @container.describe_container
    expect(response).to eq res
  end
end

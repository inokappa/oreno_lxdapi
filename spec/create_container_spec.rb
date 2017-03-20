require 'spec_helper'
require 'oreno_lxdapi'

describe OrenoLxdapi do
  before do
    @container = OrenoLxdapi::Client.new('/path/to/uri',
                                         'test-image01', 'test01')
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
end

require 'spec_helper'
require 'oreno_lxdapi'

describe OrenoLxdapi do
  before do
    @container = OrenoLxdapi::Client.new('/path/to/uri',
                                         'test-image01', 'test01')
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

require 'spec_helper'
require 'oreno_lxdapi'

describe OrenoLxdapi do
  before do
    @container = OrenoLxdapi::Client.new('/path/to/uri',
                                         'test-image01', 'test01')
  end

  it 'Has a version number' do
    expect(OrenoLxdapi::VERSION).not_to be nil
  end

  it 'Detect a oreno_lxdapi client' do
    expect(@container.client).to be_a_kind_of(Object)
  end
end

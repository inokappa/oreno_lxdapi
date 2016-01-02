# OrenoLxdapi::Client
[![Build Status](https://travis-ci.org/inokappa/oreno_lxdapi.svg)](https://travis-ci.org/inokappa/oreno_lxdapi)

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

```
$ bundle exec irb
irb(main):001:0> require 'oreno_lxdapi'
=> true
irb(main):002:0> c = OrenoLxdapi::Client.new("oreno-ubuntu-image", "test-container")                                                                                          
=> #<OrenoLxdapi::Client:0x007fafb8da07e0 @uri="unix:///var/lib/lxd/unix.socket", @image_name="oreno-ubuntu-image", @container_name="test-container">
irb(main):003:0> c.methods
=> [:client, :list_containers, :create_container, :describe_container, :check_container_status, :run_container, :stop_container, :create_exec, :file_upload, :run_exec, :run_lxc_exec, :wait_operation, :to_json, :nil?, :===, :=~, :!~, :eql?, :hash, :<=>, :class, :singleton_class, :clone, :dup, :taint, :tainted?, :untaint, :untrust, :untrusted?, :trust, :freeze, :frozen?, :to_s, :inspect, :methods, :singleton_methods, :protected_methods, :private_methods, :public_methods, :instance_variables, :instance_variable_get, :instance_variable_set, :instance_variable_defined?, :remove_instance_variable, :instance_of?, :kind_of?, :is_a?, :tap, :send, :public_send, :respond_to?, :extend, :display, :method, :public_method, :singleton_method, :define_singleton_method, :object_id, :to_enum, :enum_for, :gem, :==, :equal?, :!, :!=, :instance_eval, :instance_exec, :__send__, :__id__]
irb(main):004:0> c.create_container
=> "{\"type\":\"async\",\"status\":\"OK\",\"status_code\":100,\"metadata\":{\"id\":\"4c8b9e2a-b32f-456b-9da6-de3a0c5819d4\",\"class\":\"task\",\"created_at\":\"2015-12-30T09:23:35.760880183+09:00\",\"updated_at\":\"2015-12-30T09:23:35.760880183+09:00\",\"status\":\"Running\",\"status_code\":103,\"resources\":{\"containers\":[\"/1.0/containers/test-container\"]},\"metadata\":null,\"may_cancel\":false,\"err\":\"\"},\"operation\":\"/1.0/operations/4c8b9e2a-b32f-456b-9da6-de3a0c5819d4\"}\n"
irb(main):005:0> c.run_container
still starting...
still starting...
still starting...
=> "{\"type\":\"async\",\"status\":\"OK\",\"status_code\":100,\"metadata\":{\"id\":\"8441cf75-d16b-41b4-b7d4-ca717236ea68\",\"class\":\"task\",\"created_at\":\"2015-12-30T09:24:17.926679919+09:00\",\"updated_at\":\"2015-12-30T09:24:17.926679919+09:00\",\"status\":\"Running\",\"status_code\":103,\"resources\":{\"containers\":[\"/1.0/containers/test-container\"]},\"metadata\":null,\"may_cancel\":false,\"err\":\"\"},\"operation\":\"/1.0/operations/8441cf75-d16b-41b4-b7d4-ca717236ea68\"}\n"
irb(main):007:0> c.list_containers
=> "{\"type\":\"sync\",\"status\":\"Success\",\"status_code\":200,\"metadata\":[\"/1.0/containers/oreno-container\",\"/1.0/containers/oreno-ubuntu\",\"/1.0/containers/oreno-ubuntu01\",\"/1.0/containers/test-container\"],\"operation\":\"\"}\n"
irb(main):008:0> c.run_lxc_exec("pwd")
/root
=> true
irb(main):009:0> c.stop_container
=> "{\"type\":\"async\",\"status\":\"OK\",\"status_code\":100,\"metadata\":{\"id\":\"8bad88fa-d859-46a5-888a-8176e39ac6ee\",\"class\":\"task\",\"created_at\":\"2015-12-30T09:25:49.290624274+09:00\",\"updated_at\":\"2015-12-30T09:25:49.290624274+09:00\",\"status\":\"Running\",\"status_code\":103,\"resources\":{\"containers\":[\"/1.0/containers/test-container\"]},\"metadata\":null,\"may_cancel\":false,\"err\":\"\"},\"operation\":\"/1.0/operations/8bad88fa-d859-46a5-888a-8176e39ac6ee\"}\n"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/oreno_lxdapi.


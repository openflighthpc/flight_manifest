# FlightManifest

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/flight_manifest`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flight_manifest'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flight_manifest

## Usage

FlightManifest defines the specification for how to list components of a cluster. It is comprised of three major objects:
* [FlightManifest::Domain](https://github.com/openflighthpc/flight_manifest/blob/master/lib/flight_manifest/domain.rb)
* [FlightManifest::Group](https://github.com/openflighthpc/flight_manifest/blob/master/lib/flight_manifest/group.rb)
* [FlightManifest::Node](https://github.com/openflighthpc/flight_manifest/blob/master/lib/flight_manifest/node.rb)

Each object is a hash like [Hashie::Trash](https://github.com/intridea/hashie#trash) that defines the parameters that are allowed to be set. All other properties will be ignored by the object initializer.

### Loading the Manifest

The manifest objects can be loaded from files called `manifest.yaml` using the `FlightManifest.load(path)` method. Currently the `path` must be either:
1. The absolute path to the `manifest.yaml` file, or
2. The absolute path to the directory containing a `manifest.yaml`.

The basic structure of the manifest is:

```
domain:
  name:
  gateway_ip
  # See FlightManifest::Domain specification file for full list of properties
groups:
  - name: # The first group
    # See FlightManifest::Group specification file for full list of properties
  - name: # The second group
nodes:
  - name: # The first node
    build_ip:
    kickstart_file:
    pxelinux_file:
    # See FlightManifest::Node specification file for full list of properties
  - name: # The second node
```

Loading the file will automatically generate a collection of `Manifest` objects:

```
> manifest = FlightManifest.load
=> #<FlightManifest::Base>

> manifest.domain
=> #<FlightManifest::Domain>

> manifest.groups
=> [#<FlightManifest::Group>, ...]

> manifest.nodes
=> [#<FlightManifest::Node>, ...]
```

### File Path Handling

All file path properties are suffixed with `_file` (or `_files` for an array of paths). The paths may be either relative or absolute paths. The `FlightManifest::Base` records the base path it was loaded from. By convention, the file paths should be relative to this location.

To maintain flexibility and simplicity, the paths are not expanded. It is up to the application to decide if it will follow/ enforce the convention. This allows for the manifest object to be used without loading them from a file.

Finally, all paths are coerced into `Pathname` objects. This provides the full range of methods from `File` and `FileUtils` which are commonly used with the path. Type casting the manifest to a hash will convert the `Pathname`s to `String`s

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/flight_manifest. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the FlightManifest project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/flight_manifest/blob/master/CODE_OF_CONDUCT.md).

## License
Eclipse Public License 2.0, see LICENSE.txt for details.

Copyright (C) 2019-present Alces Flight Ltd.

This program and the accompanying materials are made available under the terms of the Eclipse Public License 2.0 which is available at https://www.eclipse.org/legal/epl-2.0, or alternative license terms made available by Alces Flight Ltd - please direct inquiries about licensing to licensing@alces-flight.com.

flight_manifest is distributed in the hope that it will be useful, but WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR CONDITIONS OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. See the Eclipse Public License 2.0 for more details.


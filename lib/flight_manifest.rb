# frozen_string_literal: true

#==============================================================================
# Copyright (C) 2019-present Alces Flight Ltd.
#
# This file is part of flight_manifest.
#
# This program and the accompanying materials are made available under
# the terms of the Eclipse Public License 2.0 which is available at
# <https://www.eclipse.org/legal/epl-2.0>, or alternative license
# terms made available by Alces Flight Ltd - please direct inquiries
# about licensing to licensing@alces-flight.com.
#
# This project is distributed in the hope that it will be useful, but
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR
# IMPLIED INCLUDING, WITHOUT LIMITATION, ANY WARRANTIES OR CONDITIONS
# OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A
# PARTICULAR PURPOSE. See the Eclipse Public License 2.0 for more
# details.
#
# You should have received a copy of the Eclipse Public License 2.0
# along with this project. If not, see:
#
#  https://opensource.org/licenses/EPL-2.0
#
# For more information on flight_manifest, please visit:
# https://github.com/alces-software/flight_manifest
#===============================================================================

require "flight_manifest/version"
require 'hashie'
require 'yaml'

module FlightManifest
  class Manifest < Hashie::Trash
    include Hashie::Extensions::Dash::Coercion
    include Hashie::Extensions::IndifferentAccess
  end
end

require 'flight_manifest/domain'
require 'flight_manifest/group'
require 'flight_manifest/node'

# Must be required last
require 'flight_manifest/base'

module FlightManifest
  FILENAME = 'manifest.yaml'

  def self.load(input_path)
    path =  if /#{FILENAME}\Z/.match?(input_path)
              input_path
            else
              File.join(input_path, FILENAME)
            end
    data = YAML.safe_load(File.read(path)).to_h
    data[:base] = File.dirname(path)
    Base.new(data)
  end
end

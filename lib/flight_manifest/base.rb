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

require 'pathname'

module FlightManifest
  class Base < Manifest
    property :base, required: true, coerce: Pathname
    property :domain, default: {}, coerce: FlightManifest::Domain
    property :groups, default: [], coerce: Array[FlightManifest::Group]
    property :nodes,  default: [], coerce: Array[FlightManifest::Node]

    def to_h
      super().map { |k,v| [k.to_sym, v] }
             .to_h
             .tap do |hash|
        hash[:domain] = hash[:domain].to_h
        [:groups, :nodes].each { |s| hash[s] = hash[s].map(&:to_h) }
        hash[:base] = hash[:base].to_s
      end
    end
  end
end

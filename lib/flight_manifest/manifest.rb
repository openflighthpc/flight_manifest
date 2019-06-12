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

require 'hashie'
require 'pathname'

module FlightManifest
  class Manifest < Hashie::Trash
    include Hashie::Extensions::Dash::Coercion
    include Hashie::Extensions::IndifferentAccess
    include Hashie::Extensions::IgnoreUndeclared

    def self.file_properties
      @file_properties ||= []
    end

    def self.files_properties
      @files_properties ||= []
    end

    def self.file_property(property)
      name = :"#{property}_file"
      self.file_properties << name
      property name, default: '', coerce: Pathname
    end

    def self.files_property(property)
      name = :"#{property}_files"
      self.files_properties << name
      property name, default: [], coerce: Array[Pathname]
    end

    def to_h
      super().map { |k,v| [k.to_sym, v] }
             .to_h
             .tap do |hash|
        self.class.file_properties.each { |p| hash[p] = hash[p].to_s }
        self.class.files_properties.each { |p| hash[p] = hash[p].map(&:to_s) }
      end
    end
  end
end


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

module FlightManifest
  class Node < Manifest
    property :name
    property :build_ip
    property :fqdn
    property :gateway_ip
    property :bmc_ip
    property :bmc_username
    property :bmc_password
    property :primary_group
    property :secondary_groups, coerce: Array
    property :kickstart, coerce: Pathname
    property :pxelinux, coerce: Pathname
    property :aws, coerce: Pathname
    property :azure, coerce: Pathname
  end
end

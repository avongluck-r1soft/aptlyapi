#######################################################
#
# AptlyAPI gem
# Copyright 2015, R1Soft.
# Released under the terms of the GPLv2
#
# Wrangle remote Aptly Servers over
# the Aptly API.
#
# Authors:
#  Alexander von Gluck IV <Alex.vonGluck@r1soft.com>
#
#######################################################

require 'uri'
require 'net/http'
require 'json'

module AptlyAPI
	##
	# This class represents an Aptly server running the Aptly API
	class AptlyServer
		##
		# Creates a new AptlyServer located at +url+
		def initialize(url)
			@server = URI(url)
			begin
				@version = JSON.parse(Net::HTTP.get(@server.host, @server.path << '/api/version', @server.port)).fetch("Version", nil)
			rescue
				return nil
			end
		end

		##
		# Compre two AptlyServer objects to see if they are identical
		def ==(r)
			r.server == server and r.version == version
		end
		attr_reader :server, :version
	end
end

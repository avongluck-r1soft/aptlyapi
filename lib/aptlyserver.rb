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
				@version = JSON.parse(Net::HTTP.get(@server.host, "#{@server.path}/api/version", @server.port)).fetch("Version", "unknown")
			rescue
				return nil
			end
		end

		def get_repos
			repos = Array.new
			remote_repos = JSON.parse(Net::HTTP.get(@server.host, "#{@server.path}/api/repos", @server.port))
			remote_repos.each do |info|
				repos.push(AptlyRepo.new(@server, info))
			end
			repos
		end

		def get_repo(name)
			repos = Array.new
			remote_repo = JSON.parse(Net::HTTP.get(@server.host, "#{@server.path}/api/repos/#{name}", @server.port))
			AptlyRepo.new(@server, info)
		end

		##
		# Compre two AptlyServer objects to see if they are identical
		def ==(r)
			r.server == server and r.version == version
		end
		attr_reader :server, :version
	end
end

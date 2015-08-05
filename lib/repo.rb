
require 'uri'
require 'net/http'
require 'json'

module AptlyAPI
	##
	# This class represents an Aptly repo
	class Repo
		##
		# Creates a new Repo definitation with data +json+ located on +server+
		def initialize(server, json)
			@server = server
			@http = Net::HTTP.new(@server.host, @server.port)

			@name = json['Name']
			@comment = json['Comment']
			@distrubution = json['DefaultDistribution']
			@component = json['DefaultComponent']
		end

		##
		# Import all files uploaded to +directory+
		def import_files(directory, options = {})
			hpost("/api/repos/#{@name}/file/#{directory}", options)
		end

		attr_reader :name, :comment, :distribution, :component

	protected
		##
		# Get an hash of JSON data from server +path+
		def hget(path)
			request = Net::HTTP::Get.new("#{@server.path}#{path}")
			response = @http.request(request)
			if response.code.to_i != 200
				return response.code.to_i
			end
			return JSON.parse(response.body)
		end

		##
		# Post +data+ hash to +path+ as JSON
		def hpost(path, data)
			request = Net::HTTP::Post.new("#{@server.path}#{path}")
			request.add_field('Content-Type', 'application/json')
			request.body = data.to_json
			response = @http.request(request)
			return response.code.to_i
		end

		##
		# Sends HTTP delete call to +path+
		def hdelete(path)
			request = Net::HTTP::Delete.new("#{@server.path}#{path}")
			response = @http.request(request)
			return response.code.to_i
		end
	end
end

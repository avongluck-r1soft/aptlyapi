
require 'uri'
require 'net/http'
require 'json'

module AptlyAPI
    ##
    # This class represents an Aptly server running the Aptly API
    class Repo
        ##
        # Creates a new AptlyRepo located at +url+
        def initialize(server, json)
			@server = server
			@name = json['Name']
			@comment = json['Comment']
			@distrubution = json['DefaultDistribution']
			@component = json['DefaultComponent']
        end
		attr_reader :name, :comment, :distribution, :component
	end
end

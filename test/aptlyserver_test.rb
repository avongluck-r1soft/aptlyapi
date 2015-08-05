require 'minitest/autorun'
require 'aptlyapi'

class TestAptlyServer < Minitest::Test
	def setup
		@server = AptlyAPI::AptlyServer.new("http://10.80.65.147:8080")
	end
	def test_server_version
		assert @server.version
	end
	def test_server_comparison
		@equal = AptlyAPI::AptlyServer.new("http://10.80.65.147:8080")
		assert_equal @server, @equal

		@not = AptlyAPI::AptlyServer.new("http://127.0.0.1:8080")
		refute_equal @server, @not
	end
end

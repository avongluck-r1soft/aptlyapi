require 'minitest/autorun'
require 'aptlyapi'

class TestAptlyServer < Minitest::Test
	def setup
		@server = AptlyAPI::Server.new("http://10.80.65.147:8080")
	end
	def test_server_version
		assert @server.version
		refute_equal "unknown", @server.version
		puts "version:#{@server.version}"
	end
	def test_server_comparison
		@equal = AptlyAPI::Server.new("http://10.80.65.147:8080")
		assert_equal @server, @equal
	end
	def test_server_get_repos
		assert @server.get_repos.kind_of?(Array)
	end
	def test_server_create_repo
		@server.create_repo("test")
		assert_equal true, @server.repo_exist?("test")
		@server.delete_repo("test")
		assert_equal false, @server.repo_exist?("test")
	end
end

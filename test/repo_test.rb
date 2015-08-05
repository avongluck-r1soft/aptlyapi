require 'minitest/autorun'
require 'aptlyapi'

class TestRepo < Minitest::Test
	def setup
		@server = AptlyAPI::Server.new("http://10.80.65.147:8080")
		@server.create_repo("test")
		@repo = @server.get_repo("test")
	end
	def test_import_files
		@repo.import_files("test")
	end
end

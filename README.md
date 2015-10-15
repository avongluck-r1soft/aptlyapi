AplyAPI
========
Restfully manage and populate remote Aptly repos

Quick Example Usage
---------------------
    @aptly = AptlyAPI::Server.new("http://myaptlyserver.com")
    @repo = @aptly.get_repo("cats")
  
    @aptly.file_upload("/my/file", "main")
    @repo.import_files("main")
    @aptly.publish_update("cats", "staging", "MySigningGPGID", "MySigningPassword")

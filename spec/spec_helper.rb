ENV['RACK_ENV']   = "test"
TEST_REDIS_KEY    = "1381332448661672|53FD0929-F033-427C-9059-91B8F55254EB.1"
TEST_REDIS_VALUE  = "Received: from dub0-omc3-s31.dub0.hotmail.com (dub0-omc3-s31.dub0.hotmail.com [157.55.2.40])\r\n\tby mail (Haraka/2.2.1) with ESMTP id 53FD0929-F033-427C-9059-91B8F55254EB.1\r\n\tenvelope-from <no-excuses@hotmail.nl>;\r\n\tWed, 09 Oct 2013 15:27:28 +0000\r\nReceived: from DUB119-W9 ([157.55.2.7]) by dub0-omc3-s31.dub0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);\r\n\t Mon, 7 Oct 2013 10:26:25 -0700\r\nX-TMN: [7am4msTSiu2ph32UOcs5k6HxLMuZi8w6]\r\nX-Originating-Email: [no-excuses@hotmail.nl]\r\nMessage-ID: <DUB119-W90347371DE75AA4A0FFB1EE130@phx.gbl>\r\nReturn-Path: no-excuses@hotmail.nl\r\nContent-Type: multipart/alternative;\r\n\tboundary=\"_6be66da3-e81c-42f5-958e-c45eb3dc4a30_\"\r\nFrom: Remco Sanders <no-excuses@hotmail.nl>\r\nTo: \"support@signature.io\" <support@signature.io>\r\nSubject: i can't open all the files\r\nDate: Mon, 7 Oct 2013 19:26:25 +0200\r\nImportance: Normal\r\nMIME-Version: 1.0\r\nX-OriginalArrivalTime: 07 Oct 2013 17:26:25.0524 (UTC) FILETIME=[5982EB40:01CEC382]\r\n\r\n--_6be66da3-e81c-42f5-958e-c45eb3dc4a30_\r\nContent-Type: text/plain; charset=\"iso-8859-1\"\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\ni can't open all the files=20\r\nplease help. \t\t \t   \t\t  =\r\n\r\n--_6be66da3-e81c-42f5-958e-c45eb3dc4a30_\r\nContent-Type: text/html; charset=\"iso-8859-1\"\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<html>\r\n<head>\r\n<style><!--\r\n.hmmessage P\r\n{\r\nmargin:0px=3B\r\npadding:0px\r\n}\r\nbody.hmmessage\r\n{\r\nfont-size: 12pt=3B\r\nfont-family:Calibri\r\n}\r\n--></style></head>\r\n<body class=3D'hmmessage'><div dir=3D'ltr'>i can't open all the files&nbsp=\r\n=3B<div><br></div><div>please help.</div> \t\t \t   \t\t  </div></body>\r\n</html>=\r\n\r\n--_6be66da3-e81c-42f5-958e-c45eb3dc4a30_--\r\n"

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require File.expand_path(File.dirname(__FILE__) + "/factories")
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

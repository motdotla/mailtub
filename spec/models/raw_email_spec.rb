# encoding: utf-8

require File.dirname(__FILE__) + '/../spec_helper'

describe RawEmail do
  let(:raw_email)  { FactoryGirl.build(:raw_email) }

  subject { raw_email }
  
  it { should be_valid }

  context "missing redis_key" do
    before { raw_email.redis_key = nil }

    it { raw_email.should_not be_valid }
  end

  context "missing source" do
    before { raw_email.source = nil }

    it { raw_email.should_not be_valid }
  end

  describe ".sync!" do
    let(:redis_key) { "1381332448661672|53FD0929-F033-427C-9059-91B8F55254EB.1" }
    let(:redis_value) { "Received: from dub0-omc3-s31.dub0.hotmail.com (dub0-omc3-s31.dub0.hotmail.com [157.55.2.40])\r\n\tby mail (Haraka/2.2.1) with ESMTP id 53FD0929-F033-427C-9059-91B8F55254EB.1\r\n\tenvelope-from <no-excuses@hotmail.nl>;\r\n\tWed, 09 Oct 2013 15:27:28 +0000\r\nReceived: from DUB119-W9 ([157.55.2.7]) by dub0-omc3-s31.dub0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);\r\n\t Mon, 7 Oct 2013 10:26:25 -0700\r\nX-TMN: [7am4msTSiu2ph32UOcs5k6HxLMuZi8w6]\r\nX-Originating-Email: [no-excuses@hotmail.nl]\r\nMessage-ID: <DUB119-W90347371DE75AA4A0FFB1EE130@phx.gbl>\r\nReturn-Path: no-excuses@hotmail.nl\r\nContent-Type: multipart/alternative;\r\n\tboundary=\"_6be66da3-e81c-42f5-958e-c45eb3dc4a30_\"\r\nFrom: Remco Sanders <no-excuses@hotmail.nl>\r\nTo: \"support@signature.io\" <support@signature.io>\r\nSubject: i can't open all the files\r\nDate: Mon, 7 Oct 2013 19:26:25 +0200\r\nImportance: Normal\r\nMIME-Version: 1.0\r\nX-OriginalArrivalTime: 07 Oct 2013 17:26:25.0524 (UTC) FILETIME=[5982EB40:01CEC382]\r\n\r\n--_6be66da3-e81c-42f5-958e-c45eb3dc4a30_\r\nContent-Type: text/plain; charset=\"iso-8859-1\"\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\ni can't open all the files=20\r\nplease help. \t\t \t   \t\t  =\r\n\r\n--_6be66da3-e81c-42f5-958e-c45eb3dc4a30_\r\nContent-Type: text/html; charset=\"iso-8859-1\"\r\nContent-Transfer-Encoding: quoted-printable\r\n\r\n<html>\r\n<head>\r\n<style><!--\r\n.hmmessage P\r\n{\r\nmargin:0px=3B\r\npadding:0px\r\n}\r\nbody.hmmessage\r\n{\r\nfont-size: 12pt=3B\r\nfont-family:Calibri\r\n}\r\n--></style></head>\r\n<body class=3D'hmmessage'><div dir=3D'ltr'>i can't open all the files&nbsp=\r\n=3B<div><br></div><div>please help.</div> \t\t \t   \t\t  </div></body>\r\n</html>=\r\n\r\n--_6be66da3-e81c-42f5-958e-c45eb3dc4a30_--\r\n" }

    before do
      REDIS.set(redis_key, redis_value)
      RawEmail.sync!
    end

    it { RawEmail.count.should eq 1 }
    it { RawEmail.redis_keys.count.should eq 0 }
  end

  describe "#save" do
    before { raw_email.save! }

    it { raw_email.created_at.should_not be_blank }
    it { raw_email.microtime.should_not be_blank }
  end
end

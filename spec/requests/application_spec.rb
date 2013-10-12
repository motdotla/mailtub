require 'spec_helper'

describe "/" do
  include Rack::Test::Methods

  def app
    Application
  end

  let(:body)  { last_response.body }
  let(:json)  { JSON.parse(body) }

  describe "GET /" do
    before do
      get "/", {}, format: 'json'
    end

    it { json['success'].should eq true }
  end

  describe "GET /sync.json" do
    before do
      REDIS.set(TEST_REDIS_KEY, TEST_REDIS_VALUE)
      get "/sync.json", {}, format: 'json'
    end

    it do
      json['success'].should eq true
      RawEmail.count.should eq 1
    end

    describe "GET /raw_emails/index.json" do
      before do
        get "/raw_emails/index.json", {}, format: 'json'
      end

      it do
        json['success'].should eq true
        json['raw_emails'].count.should eq 1
        json['raw_emails'][0]['source'].should eq TEST_REDIS_VALUE
      end
    end
  end


end

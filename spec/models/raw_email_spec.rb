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

  describe "#save" do
    before { raw_email.save! }

    it { raw_email.created_at.should_not be_blank }
  end
end

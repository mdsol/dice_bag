require "spec_helper"
require "dice_bag/configuration"

module DiceBag
  shared_examples_for "configuration in production" do
    it "returns values ending in ! available in the environment" do
      expect(Configuration.new.test_var!).to eq(value)
    end
    it "returns values not ending in ! not available in the environment" do
      expect(Configuration.new.idontexist).to eq(nil)
    end
    it "raises an exception when the value ends in ! and is not available in the environment" do
      expect { Configuration.new.idontexist! }.to raise_exception(StandardError)
    end
  end

  RSpec.describe Configuration do
    let(:value) { "42" }
    before(:each) do
      ENV["TEST_VAR"] = value
    end

    it "returns values" do
      expect(Configuration.new.test_var).to eq(value)
    end
    it "returns values ending in !" do
      expect(Configuration.new.test_var!).to eq(value)
    end

    context "Running in Rails production environment" do
      before(:each) do
        rails = class_double("Rails")
        allow(rails).to receive_message_chain("env.production?") { true }
        stub_const("Rails", rails)
      end
      it_behaves_like "configuration in production"
    end

    context "Running in Sinatra production environment" do
      before(:each) do
        sinatra = class_double("Sinatra")
        allow(sinatra).to receive(:production?).and_return(true)
        stub_const("Sinatra::Application", sinatra)
      end
      it_behaves_like "configuration in production"
    end

    context "Running in a rack app production environment" do
      # Not the most elegant but given how much we use ENV in these tests, does seem good enough
      before(:each) do
        ENV["RACK_ENV"] = "production"
      end
      after(:each) do
        ENV["RACK_ENV"] = nil
      end
      it_behaves_like "configuration in production"
    end
  end
end

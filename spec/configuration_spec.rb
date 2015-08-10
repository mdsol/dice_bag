require 'spec_helper'
require 'dice_bag/configuration'
require 'byebug'
module DiceBag

  RSpec.describe Configuration do
    let(:value) { '42' }
    before(:each) do
      ENV['TEST_VAR'] = value
    end

    it "returns values" do
      expect(Configuration.new.test_var).to eq(value)
    end
    it "returns values ending in !" do
      expect(Configuration.new.test_var!).to eq(value)
    end

    context 'Running in Rails production environment' do
      before(:each) do
        #allow(Kernel).to receive(:defined?).and_return(true)
        rails = class_double('Rails')
        allow(rails).to receive_message_chain("env.production?") { true }
        stub_const("Rails", rails)
        #allow(Kernel).to receive(:Rails).and_return(rails)
      end

      it 'returns values ending in ! available in the environment' do
        expect(Configuration.new.test_var!).to eq(value)
      end
      it 'returns values not ending in ! not available in the environment' do
        expect(Configuration.new.idontexist).to eq(nil)
      end
      it 'raises an exception when the value ends in ! and is not available in the environment' do
        expect{Configuration.new.idontexist!}.to raise_exception(StandardError)
      end
    end
  end
end

require "spec_helper"
require "dice_bag/project"

describe DiceBag::Project do
  let(:project) { DiceBag::Project }

  describe "#name" do
    it "should give me a default name for non Rails apps" do
      expect(project.name).to eq(DiceBag::Project::DEFAULT_NAME)
    end

    context "Rails app" do
      let(:name) { "HelloService" }
      let(:rails) { Class.new }
      before { stub_const("Rails", rails) }

      describe "Rails < 6.1" do
        before do
          allow(Module).to receive(:parent_name).and_return(name)
          allow(rails).to receive_message_chain(:application, :class, :parent_name).and_return(name)
        end

        it "uses the :parent_name method" do
          expect(project.name).to eq("helloservice")
        end
      end

      describe "Rails >= 6.1" do
        before do
          allow(Module).to receive(:module_parent_name).and_return(name)
          allow(rails).to receive_message_chain(:application, :class, :module_parent_name).and_return(name)
        end

        it "uses the :module_parent_name method" do
          expect(project.name).to eq("helloservice")
        end
      end
    end
  end
end

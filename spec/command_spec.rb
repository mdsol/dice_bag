require "spec_helper"
require "dice_bag/project"

describe DiceBag::Project do
  let(:project) { DiceBag::Project }

  describe "#name" do
    it "should give me a default name for non Rails apps" do
      expect(project.name).to eq(DiceBag::Project::DEFAULT_NAME)
    end
  end
end

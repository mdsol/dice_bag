# frozen_string_literal: true

require "spec_helper"
require "dice_bag/project"
require "dice_bag/template_file"

RSpec.describe DiceBag::TemplateFile do
  let(:file_name) { "config/database.yml" }
  let(:template_name) { "#{file_name}.dice" }
  let(:template_file) { DiceBag::TemplateFile.new(template_name) }
  let(:config_file) { double(file: file_name) }
  let(:params) { { deploy: true } }

  before do
    allow(ENV).to receive(:[]).with("DATABASE_USERNAME").and_return("alice")
    allow(ENV).to receive(:[]).with("DATABASE_PASSWORD").and_return("xyzzy")
    allow(DiceBag::Project).to receive(:root).and_return(File.join(__dir__, "support"))
  end

  it "writes to configuration file" do
    expect(config_file)
      .to receive(:write).with("development:\n  database: development\n  username: alice\n  password: xyzzy\n")
    template_file.create_file(config_file, params)
  end
end

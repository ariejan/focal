require 'spec_helper'

describe Burndown do

  context "relations" do
    it { should have_many(:iterations).order("number DESC").dependent(:destroy) }
    it { should have_many(:metrics).through(:iterations) }
  end

  context "import from Pivotal Tracker" do
    let(:one) { FactoryGirl.create(:burndown, pivotal_project_id: 42, pivotal_token: "ABC") }
    let(:two) { FactoryGirl.create(:burndown, pivotal_project_id: 88, pivotal_token: "XYZ") }

    before do
      Burndown.stub(:find_each).and_yield(one).and_yield(two)
    end

    it "for all burndowns" do
      one.should_receive(:import).once
      two.should_receive(:import).once

      Burndown.import_all
    end
  end
end

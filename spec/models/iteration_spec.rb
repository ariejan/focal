require 'spec_helper'

describe Iteration do
  context "relations" do
    it { should belong_to(:burndown) }
    it { should have_many(:metrics).order("captured_on ASC").dependent(:destroy) }
  end

  context "utc offset" do
    let(:burndown) { FactoryGirl.create(:burndown, utc_offset: 3600) }
    subject(:iteration) { FactoryGirl.create(:iteration,
      burndown:  burndown,
      start_at:  DateTime.parse("2013/02/11 00:00:00 CET"),
      finish_at: DateTime.parse("2013/02/24 00:00:00 CET"))
    }

    it "returns the correct start_at" do
      expect(iteration.start_at.to_s).to eql("2013-02-11 00:00:00 +0100")
    end

    it "returns the correct finish_at" do
      expect(iteration.finish_at.to_s).to eql("2013-02-24 00:00:00 +0100")
    end
  end

  context "dates" do
    subject { FactoryGirl.create :iteration }

    it { expect(subject.start_on).to  eql(subject.start_at.to_date) }
    it { expect(subject.finish_on).to eql(subject.finish_at.to_date) }
  end
end

require 'spec_helper'

describe Burndown do
  context "relations" do
    it { should have_many :iterations }
  end

  context "with iterations" do
    context "#last_iteration" do
      subject(:burndown) { Fabricate(:burndown) }

      context "without known iterations" do
        it "returns nil" do
          expect(burndown.last_iteration).to be_nil
        end
      end

      context "with known interations" do
        before do
          Fabricate(:iteration, burndown: burndown, pivotal_iteration_number: 14)
          Fabricate(:iteration, burndown: burndown, pivotal_iteration_number: 13)
        end

        it "returns the last iteration number" do
          expect(burndown.last_iteration).to eql(14)
        end
      end
    end
  end

  context "import from Pivotal Tracker" do
    let(:one) { Fabricate(:burndown, pivotal_project_id: 42, pivotal_token: "ABC") }
    let(:two) { Fabricate(:burndown, pivotal_project_id: 88, pivotal_token: "XYZ") }

    before do
      Burndown.stub(:find_each).and_yield(one).and_yield(two)
    end

    it "for all burndowns" do
      one.should_receive(:import).once
      two.should_receive(:import).once

      Burndown.import_all
    end
  end

  context "reports data for current iteration" do
    subject(:burndown) { Fabricate(:burndown, pivotal_project_id: 42) }

    context "when there is data available" do
      before do
        Fabricate(:metric, project_id: 42, captured_on: "2013-02-24")
        Fabricate(:metric, project_id: 42, captured_on: "2013-02-25")
      end

      it "returns json data" do
        expect(burndown.json_data).to have(3).elements

        expect(burndown.json_data[0]).to eql(['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected'])
        expect(burndown.json_data[1]).to eql(['Sun 24', 5, 8, 13, 21, 34, 55])
        expect(burndown.json_data[2]).to eql(['Mon 25', 5, 8, 13, 21, 34, 55])
      end

      it "returns assorted data" do
        expect(burndown.data).to have(2).elements

        metric = burndown.data.first
        expect(metric.captured_on).to eql(Date.parse("2013-02-24"))  # date
        expect(metric.unstarted).to   eql(5)
        expect(metric.started).to     eql(8)
        expect(metric.finished).to    eql(13)
        expect(metric.delivered).to   eql(21)
        expect(metric.accepted).to    eql(34)
        expect(metric.rejected).to    eql(55)
      end
    end

    context "when there is no data available" do
      it "returns an empty array" do
        expect(burndown.data).to eql([])
      end
    end
  end
end

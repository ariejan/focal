require 'spec_helper'

describe Burndown do
  subject(:burndown) { Fabricate(:burndown, pivotal_project_ids: "112,42") }

  context "reports data for current iteration" do
    context "when there is data available" do

      before do
        Fabricate(:metric, project_id: 42, captured_on: "2013-02-24")
        Fabricate(:metric, project_id: 42, captured_on: "2013-02-25")
      end

      it "returns assorted data" do
        expect(burndown.data).to have(2).elements

        expect(burndown.data.keys).to include("2013-02-24", "2013-02-25")
      end

      context "with multiple projects" do
        before do
          Fabricate(:metric, project_id: 112, captured_on: "2013-02-24", unstarted: 7)
        end

        it "returns merged data" do
          expect(burndown.data).to have(2).elements
          expect(burndown.data["2013-02-24"].unstarted).to eql(34 + 7)
        end
      end
    end

    context "when there is no data available" do
      it "returns an empty array" do
        expect(burndown.data).to eql({})
      end
    end
  end
end

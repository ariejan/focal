require 'spec_helper'

describe Metric do
  context "merging" do
    let(:one) { Fabricate(:metric, iteration_id: 12, project_id: 42, unstarted: 12) }
    let(:two) { Fabricate(:metric, iteration_id: 11, project_id: 42, unstarted: 6) }

    subject(:result) { one.merge(two) }

    it "merges two metrics" do
      expect(result.unstarted).to eql(12 + 6)
    end
  end

  context "last_iteration" do
    it "returns nil if there is no data" do
      expect(Metric.last_iteration_for_project_id(42)).to be_nil
    end

    context "with one ore more metrics" do
      before do
        Fabricate(:metric, iteration_id: 12, project_id: 42)
        Fabricate(:metric, iteration_id: 11, project_id: 42)
      end

      it "returns the latest iteration" do
        expect(Metric.last_iteration_for_project_id(42)).to eql(12)
      end
    end
  end
end

require 'spec_helper'

describe Burndown do

  context "relations" do
    it { should have_many(:iterations).order("number DESC").dependent(:destroy) }
    it { should have_many(:metrics).through(:iterations) }
  end

  context "Pivotal Proxy" do
    context "#proxy" do
      subject(:burndown) { FactoryGirl.create(:burndown, pivotal_project_id: 42, pivotal_token: "ABC") }

      it "creates a new Pivotal Proxy for this burndown" do
        PivotalProxy.should_receive(:new).with("ABC", 42).once
        burndown.proxy
      end
    end
  end

  context "import from Pivotal Tracker" do
    context "for a single burndown" do
      subject(:burndown) { FactoryGirl.create(:burndown, pivotal_project_id: 42, pivotal_token: "ABC") }

      context "imports fresh data" do
        before do
          PivotalProxy.any_instance.stub(:get_current_iteration_number).and_return(11)
        end

        it "creates a new iteration" do
          expect {
            burndown.import
          }.to change { burndown.iterations.count }.by(1)
        end

        it "creates a new metric" do
          expect {
            burndown.import
          }.to change{ burndown.metrics.count }.by(1)
        end

        context "stores proper metric data" do

          let(:metric) { burndown.metrics.last }

          before do
            burndown.import
          end

          specify { expect(metric.unstarted).to eql(5) }

        end
      end
    end

    context "for all the burndowns" do
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
end

require 'spec_helper'

describe BurndownDecorator do
  subject(:burndown) {
    BurndownDecorator.decorate(
      FactoryGirl.create(:burndown_with_metrics,
        pivotal_project_id: 123123,
        iteration_count: 3
      )
    )
  }

  context "#pivotal_tracker_url" do
    it "returns URL to pivotal tracker" do
      expected = "https://pivotaltracker.com/projects/123123"
      expect(burndown.pivotal_tracker_url).to eql(expected)
    end
  end

  context "#start_on" do
    it "returns the start date" do
      expect(burndown.start_on).to eql(burndown.current_iteration.start_at.strftime("%F"))
    end
  end

  context "#finish_on" do
    it "returns the finish date" do
      expect(burndown.finish_on).to eql(burndown.current_iteration.finish_at.strftime("%F"))
    end
  end

  context "#iteration_number" do
    it "returns the current iteation number" do
      expect(burndown.current_iteration.number).to eql(3)
    end
  end

  context "#to_json" do
    it "returns the correct JSON" do
      base_date = burndown.current_iteration.start_at
      expected = [
        ['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected'],
        [(base_date + 0.days).strftime("%a %e"), 5, 8, 13, 21, 34, 55],
        [(base_date + 1.days).strftime("%a %e"), 5, 8, 13, 21, 34, 55],
        [(base_date + 2.days).strftime("%a %e"), 5, 8, 13, 21, 34, 55]
      ].to_json

      expect(burndown.to_json).to be_json_eql(expected)
    end
  end
end

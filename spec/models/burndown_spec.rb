require 'spec_helper'

describe Burndown do
  subject(:burndown) { Fabricate(:burndown) }

  context "reports data for current iteration" do
    context "when there is no data available" do
      it "returns an empty array" do
        expect(burndown.data).to eql([])
      end
    end
  end
end

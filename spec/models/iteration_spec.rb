require 'spec_helper'

describe Iteration do
  context "relations" do
    it { should belong_to :burndown }
  end
end

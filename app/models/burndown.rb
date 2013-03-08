class Burndown < ActiveRecord::Base

  has_many :iterations,
    order: "number DESC",
    dependent: :destroy

  has_many :metrics,
    through: :iterations

  # Import metrics for all projects
  def self.import_all
    Burndown.find_each { |burndown| burndown.import }
  end

  def import
    iteration = iterations.find_or_create_by_number(proxy.get_current_iteration_number)
  end

  def proxy
    @proxy ||= PivotalProxy.new(pivotal_token, pivotal_project_id)
  end
end

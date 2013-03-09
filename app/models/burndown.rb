class Burndown < ActiveRecord::Base

  has_many :iterations,
    order: "number DESC",
    dependent: :destroy

  has_many :metrics,
    order: "metrics.captured_on ASC",
    through: :iterations

  # Import metrics for all projects
  def self.import_all
    Burndown.find_each { |burndown| burndown.import }
  end

  def import
    # Create or update the iteration
    iteration = iterations.find_or_create_by_number(pivotal_iteration.number) do |obj|
      obj.pivotal_iteration_id = pivotal_iteration.pivotal_id
      obj.start_at             = pivotal_iteration.start_at
      obj.finish_at            = pivotal_iteration.finish_at
    end

    # Create metrics for today
    metric = Metric.create do |m|
      m.iteration = iteration
      m.captured_on = Time.now.utc.to_date

      %w(unstarted started finished delivered accepted rejected).each do |state|
        m.send("#{state}=", pivotal_iteration.send("#{state}"))
      end
    end
  end

  private
  def pivotal_iteration
    @pivotal_iteration ||= PivotalIteration.new(pivotal_token, pivotal_project_id)
  end
end

class Metric < ActiveRecord::Base

  # Return the last iteration_id known for a project
  def self.last_iteration_for_project_id(project_id)
    Metric.where(project_id: project_id).maximum(:iteration_id)
  end

  # Merge two metrics into one
  def merge(other)
    # Add up attributes
    %w(unstarted started finished delivered accepted rejected).each do |attr|
      self.send(:"#{attr}=", self.send(:"#{attr}") + other.send(:"#{attr}"))
    end

    return self
  end
end

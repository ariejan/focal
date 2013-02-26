class Burndown < ActiveRecord::Base

  # Return data to plot a burndown for the last available iteration
  def data
    result = {}

    pivotal_project_ids.split(",").map { |i| i.scan(/\d+/) }.each do |project_id|
      last_iteration = Metric.last_iteration_for_project_id(project_id)

      # Skip if we don't have any data on this project yet.
      next if last_iteration.nil?

      # Collect the resulting metrics
      Metric.where(project_id: project_id, iteration_id: last_iteration)
        .order("captured_on ASC").find_each do |metric|
        key = metric.captured_on.to_s

        if result.has_key?(key)
          result[key].merge(metric)
        else
          result[key] = metric
        end
      end
    end

    result
  end
end

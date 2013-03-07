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

  end



  # Return a google charts compatible array of data
  #def json_data
  #  result = []
  #  result << ['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected']
  #  data.each do |d|
  #    result << [d.captured_on.strftime("%a %e"), d.unstarted, d.started, d.finished, d.delivered, d.accepted, d.rejected]
  #  end
  #  result
  #end

  # Return data to plot a burndown for the last available iteration
  #def data
  #  # Gather project_id and iteration data
  #  return [] if iterations.empty?
  #
  #  # Fetch data, one row per day
  #  select = "captured_on, SUM(unstarted) AS unstarted, SUM(started) AS started, SUM(finished) AS finished, SUM(delivered) AS delivered, SUM(accepted) AS accepted, SUM(rejected) AS rejected"
  #end
end

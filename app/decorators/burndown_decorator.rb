class BurndownDecorator < Draper::Decorator
  delegate_all

  def pivotal_tracker_url
    "https://pivotaltracker.com/projects/#{source.pivotal_project_id}"
  end

  def iteration_number
    source.current_iteration.number
  end

  def start_on
    source.current_iteration.start_at.strftime("%F")
  end

  def finish_on
    source.current_iteration.finish_at.strftime("%F")
  end

  def to_json
    result = []
    result << ['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected']
    source.current_iteration.metrics.each do |m|
      result << [m.captured_on.strftime("%a %e"), m.unstarted, m.started, m.finished, m.delivered, m.accepted, m.rejected]
    end

    result.to_json
  end
end

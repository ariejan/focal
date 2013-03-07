class Metric < ActiveRecord::Base

  belongs_to :iteration

  #def fetch_from_pivotal_tracker
  #  PivotalTracker::Client.token = token
  #
  #  project   = PivotalTracker::Project.find(project_id)
  #  iteration = project.iteration(:current)
  #  stories   = iteration.stories
  #
  #  self.project_id   = project_id
  #  self.iteration_id = project.current_iteration_number
  #  self.captured_on  = Time.now.utc.to_date
  #
  #  self.unstarted = sum_estimates(stories, "unstarted")
  #  self.started   = sum_estimates(stories, "started")
  #  self.finished  = sum_estimates(stories, "finished")
  #  self.delivered = sum_estimates(stories, "delivered")
  #  self.accepted  = sum_estimates(stories, "accepted")
  #  self.rejected  = sum_estimates(stories, "rejected")
  #end
  #
  #def sum_estimates(stories, state)
  #  stories.inject(0) do |sum, story|
  #    story.story_type == "feature" && story.current_state == state ? sum + calculate_cp(story) : sum
  #  end
  #end
  #
  ## Calculate the actual complexity points of a story. This method handles negative and nil
  ## values that the Pivotal Tracker API gives us.
  #def calculate_cp(story)
  #  [story.estimate || 0, 0].max
  #end

end

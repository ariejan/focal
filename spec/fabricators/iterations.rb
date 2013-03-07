Fabricator(:iteration) do
  burndown

  pivotal_iteration_id      123123
  pivotal_iteration_number  42

  starts_at                 { 1.week.ago }
  finished_at               { 1.week.from_now }
end

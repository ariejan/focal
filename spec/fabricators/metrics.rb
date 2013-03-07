Fabricator(:metric) do
  iteration_id 1
  project_id   1
  captured_on  { Time.now.to_date }

  unstarted    5
  started      8
  finished     13
  delivered    21
  accepted     34
  rejected     55
end
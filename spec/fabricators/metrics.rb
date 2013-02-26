Fabricator(:metric) do
  iteration_id 1
  project_id   1
  captured_on  { Time.now.to_date }

  unstarted    34
  started      8
  finished     5
  delivered    23
  accepted     8
  rejected     3
end


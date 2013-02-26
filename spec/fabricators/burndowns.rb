Fabricator(:burndown) do
  name { sequence { |i| "Burndown #{i}" } }
  pivotal_token "pivotal-token"
  pivotal_project_ids "123,42"
end

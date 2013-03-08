Given /^we fake Pivotal Tracker$/ do
  # TODO: Setup webmock here as needed.
end

When /^the system imports metrics from Pivotal Tracker$/ do
  Burndown.import_all
end

Then /^I can see my burndown was updated$/ do
  expect(page.source).to_not have_content(BurndownDecorator.decorate(@my_burndown).to_json)
  step "I look at my burndown"
  expect(page.source).to have_content(BurndownDecorator.decorate(@my_burndown).to_json)
end
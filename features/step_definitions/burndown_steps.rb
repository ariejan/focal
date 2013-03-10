Given /^I have a burndown$/ do
  @my_burndown = FactoryGirl.create(:burndown_with_metrics)
end

When /^I look at my burndown$/ do
  visit "/burndowns/#{@my_burndown.id}"
end

Then /^I can see a Google Chart$/ do
  expect(page.source).to have_css("#burndown-chart svg")
end

Then /^I can see sprint progress$/ do
  expect(page.source).to have_content(BurndownDecorator.decorate(@my_burndown).to_json)
end

Then /^I can see the burndown name$/ do
  within("#burndown_#{@my_burndown.id}") do
    expect(page).to have_content(@my_burndown.name)
  end
end

Then /^I can see the current iteration number$/ do
  within("#burndown_#{@my_burndown.id}") do
    expect(page).to have_content("Current iteration: #{@my_burndown.iterations.last.number}")
  end
end

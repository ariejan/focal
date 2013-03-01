Given /^my burndown is available$/ do
  @my_burndown = Fabricate(:burndown)
end

When /^I look at my burndown$/ do
    visit "/burndowns/#{@my_burndown.id}"
end

Then /^I can see sprint progress$/ do
    expect(page.source).to have_css("#burndown-chart svg")
end

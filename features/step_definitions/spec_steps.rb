Given /^this specification:$/ do |content|
  open("#{TMP}/spec.rb", 'w') do |file|
    file.puts "require 'rspec_outlines'"
    file.print content
  end
end

When /^I run rspec on it$/ do
  @output = `bundle exec rspec "#{TMP}/spec.rb" 2>&1`
end

When /^I run rspec with "(.*)" on it$/ do |args|
  @output = `bundle exec rspec #{args} "#{TMP}/spec.rb" 2>&1`
end

Then /^the output should contain "(.*?)"$/ do |string|
  @output.should include(string)
end

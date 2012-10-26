# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  # Then I should see e1
  # And I should see e2
  page.body.to_s.partition(e2)[0].include?(e1).should == true
  #page.partition(e2).head.should have content(e1)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Then /I should see (\d+) of the movies/ do |number_of_movies|
  rows = page.body.scan(/<tr>/).length
  (rows-1).should == Integer(number_of_movies)
end

Then /I should see all of the movies/ do
  rows = page.body.scan(/<tr>/).length
  (rows-1).should == 10
end

When /I (un)?check the following ratings: "(.*)"/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split.each do |rating|
    if (uncheck == true)
      check("ratings[#{rating}]")
    else
      uncheck("ratings[#{rating}]")
    end
  end
end

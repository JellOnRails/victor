
# ==== STEPS ====

When /^Access the Victor website and sign in$/ do
  @app.home_page.load
  @app.home_page.sign_in_as 'victor_valid_user'
end

When /^Navigate to My Account, (\w+)$/ do |item|
  @app.home_page.navigate_to_my_account item
end

# ==== EXPECTATIONS ====

Then /^Expect to see my account (\w+) page$/ do |page|
  expect(@app.send(page.mv_page_name)).to be_displayed
end

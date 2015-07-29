
# ==== STEPS ====

When /^Select (\w+) on (\w+) page$/ do |item, page|
  @app.send(page.mv_page_name).mv_menu.navigate_to item
end
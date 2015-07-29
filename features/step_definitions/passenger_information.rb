
# ==== STEPS ====

When /^Select (\w+) in (\w+) menu$/ do |item, page|
  @app.send(page.mv_page_name).navigate_to item
end


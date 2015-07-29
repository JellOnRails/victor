
class MvMenu < SitePrism::Section

# -- item --
  element :alerts, '.arrow-toggle[href="#myalerts"]'

  def navigate_to(item)
    self.send(item.downcase.to_sym).click
  end

end
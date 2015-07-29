
class MvSettingsMenu < SitePrism::Section

# -- item --
  element :passenger_information, '#mysettings a[href="/mv/settings/passengerinfo"]'

end

class MvSettingsPage < SitePrism::Page

  set_url "/mv/settings{/chapter}"

# -- menu --
  section :mv_settings_menu, MvSettingsMenu, '#mysettings'

  def navigate_to(item)
    mv_settings_menu.send(item.downcase.to_sym).click
  end

end

require_relative 'mv_menu'

class MvFlightsPage < SitePrism::Page

  set_url "/mv/flights{/chapter}"

# -- menu --
  section :mv_menu, MvMenu, '#accordion'

end
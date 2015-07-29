
class AuthDialog < SitePrism::Section

# -- field --
  element :username_field, '.victorAuthUsername'
  element :password_field, '.victorAuthPassword'

# -- button --
  element :sign_in_button, '.ui-dialog-content #loginLink'

end

class MyAccountMenu < SitePrism::Section

# -- item --
  element :flights, '.dropdown-menu a[href="/mv/flights/upcoming"]'
  element :settings, '.dropdown-menu a[href="/mv/settings/mydetails"]'

end

class HomePage < SitePrism::Page

  set_url '/#'

# -- button --
  element :login_button, '#loginlink'
  element :my_account_button, '#myaccount'

# -- section --
  section :auth_dialog, AuthDialog, '.victorAuthDialog'
  section :my_account_menu, MyAccountMenu, '.dropdown-menu'

  def sign_in_as(usr)
    user = get_user_info(usr)
    login_button.click
    auth_dialog.username_field.set user['username']
    auth_dialog.password_field.set user['password']
    auth_dialog.sign_in_button.click
  end

  def navigate_to_my_account(item)
    my_account_button.hover
    my_account_menu.send(item.downcase.to_sym).click
  end

end
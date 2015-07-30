
def get_user_info(usr, cfg = CONFIG)
  begin
    user = cfg['users'].fetch(usr)
  rescue e
    raise "No such user configured: <#{usr}> => #{e.message}"
  end

  user['password'] = Base64.decode64(user['password_encoded'].dup) unless user['password_encoded'].nil?

  user
end

def get_env_url
  CONFIG['environment']["#{ENV[ 'ENV' ]}"]['url']
end

public

def mv_page_name
  "mv_#{self.downcase}_page".to_sym
end
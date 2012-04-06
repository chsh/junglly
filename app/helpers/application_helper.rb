# -*- coding: UTF-8 -*-
module ApplicationHelper
  def date_format(date)
    wdays = %w(日 月 火 水 木 金 土)
    "#{date.month}/#{date.day} (#{wdays[date.wday]})"
  end
  def user_link
    if current_user
      link_to current_user.name,
              destroy_user_session_path,
              method: :delete
    else
      link_to 'Signin with facebook',
              user_omniauth_authorize_path(:facebook)
    end
  end
end

# -*- coding: UTF-8 -*-
module ApplicationHelper
  def date_format(date)
    wdays = %w(日 月 火 水 木 金 土)
    "#{date.month}/#{date.day} (#{wdays[date.wday]})"
  end
end

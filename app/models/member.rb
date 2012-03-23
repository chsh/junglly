require 'uri'
require 'open-uri'

class Member
  def self.from_text(members_text)
    member_urls = members_text.strip.split(/\r?\n/).select { |line| line.present? }
    facebook_ids = member_urls.map do |member_url|
      facebook_id_from_uri(member_url)
    end
    facebook_ids.map do |facebook_id|
      instance = new(facebook_id)
      instance.profile # load profile
      instance
    end
  end

  attr_accessor :charged_at

  def initialize(facebook_id)
    @facebook_id = facebook_id
  end

  def icon_url
    "http://graph.facebook.com/#{@facebook_id}/picture"
  end
  def name
    profile['name']
  end
  def link
    @link ||= build_link
  end

  def profile
    @profile ||= build_profile
  end
  private
  def build_profile
    text = open("http://graph.facebook.com/#{@facebook_id}").read
    JSON.parse(text)
  end
  def build_link
    profile['link'] || "http://www.facebook.com/#{@facebook_id}"
  end
  def self.facebook_id_from_uri(member_url)
    uri = URI.parse(member_url)
    return nil unless uri.scheme =~ /^https?$/
    return nil unless %w(facebook.com www.facebook.com).include? uri.host
    return $1 if uri.path =~ /^\/profile\.php$/ && uri.query =~ /\bid=(\d+)$/
    return $1 if uri.path =~ /^\/(.+)$/
    nil
  end
end

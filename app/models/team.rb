require 'member'

class Team < ActiveRecord::Base
  before_save do
    self[:members] = build_members.to_yaml
  end

  def members
    @members ||= YAML.load(self[:members])
  end

  def current_members
    today = Date.today
    if today <= started_at
      self.members.each_with_index do |member, offset|
        member.charged_at = started_at + offset
      end
      self.members
    else
      top = today - 1
      past_days = ((top.to_time - started_at.to_time) / (3600*24)).to_i
      mod = past_days % self.members.size
      ms = self.members.rotate(mod)
      ms.each_with_index do |member, offset|
        member.charged_at = top + offset
      end
      ms
    end
  end
  private
  def build_members
    Member.from_text(self.members_text)
  end
end

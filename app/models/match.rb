class Match < ApplicationRecord
  after_initialize :set_defaults

  private
  def set_defaults
    self.goals_team_a ||= 0
    self.goals_team_b ||= 0
  end
end

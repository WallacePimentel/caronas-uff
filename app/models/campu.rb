class Campu < ApplicationRecord
  enum status: { active: 0, inactive: 1 }

  before_save :set_deactivation_date

  private 

  def set_deactivation_date
    if inactive? && deactivation_date.nil?
      self.deactivation_date = Date.today
    elsif active?
      self.deactivation_date = nil
    end
  end
end

class Campu < ApplicationRecord
  enum status: { ativo: 0, inativo: 1 }

  before_save :set_deactivation_date

  private 

  def set_deactivation_date
    if inativo? && deactivation_date.nil?
      self.deactivation_date = DateTime.now
    elsif ativo?
      self.deactivation_date = nil
    end
  end
end

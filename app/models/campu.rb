class Campu < ApplicationRecord
  enum status: { ativo: 0, inativo: 1 }

  before_save :set_deactivation_date

  
  scope :active, -> { where(status: :ativo) }
  
  # Scope to search for cities with case-insensitive partial matches in attributes 
  # (description, city, district)
  scope :search_by_term, ->(term) { 
    return all if term.blank?
    sanitized_term = term.strip
    where(
      "description LIKE ? OR city LIKE ? OR district LIKE ?", 
      "%#{sanitized_term}%", "%#{sanitized_term}%", "%#{sanitized_term}%"
    ) 
  }
  
  scope :limited, ->(limit) { 
    limit.to_i > 0 ? limit(limit) : all 
  }
  
  # Combined scope for select2 autocomplete
  scope :for_select2, ->(query: nil, limit: nil) {
    scope = active.order(:description)
    scope = scope.search_by_term(query) if query.present?
    scope = scope.limited(limit) if limit.present?
    scope
  }

  private 

  def set_deactivation_date
    if inativo? && deactivation_date.nil?
      self.deactivation_date = DateTime.now
    elsif ativo?
      self.deactivation_date = nil
    end
  end
end
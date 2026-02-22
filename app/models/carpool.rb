class Carpool < ApplicationRecord
  belongs_to :beginning_campus, class_name: 'Campu', optional: true
  belongs_to :ending_campus, class_name: 'Campu', optional: true
  has_many :places, dependent: :destroy
  accepts_nested_attributes_for :places, allow_destroy: true, reject_if: :all_blank

  validate :campus_or_stop_present

  private
  def campus_or_stop_present
    missing_beginning_campus = beginning_campus.nil?
    missing_ending_campus = ending_campus.nil?

    if missing_beginning_campus && missing_ending_campus
      errors.add(:base, t(:'error.carpool.no_campus'))
    elsif (missing_beginning_campus && places.empty?) || (missing_ending_campus && places.empty?)
      errors.add(:base, t(:'error.carpool.no_stops'))
    end
  end
end

class Carpool < ApplicationRecord
  belongs_to :beginning_campus, class_name: 'Campu'
  belongs_to :ending_campus, class_name: 'Campu'
  has_many :places, dependent: :destroy
  accepts_nested_attributes_for :places, allow_destroy: true, reject_if: :all_blank
end

class Carpool < ApplicationRecord
  belongs_to :beginning_campus, class_name: 'Campu'
  belongs_to :ending_campus, class_name: 'Campu'
end

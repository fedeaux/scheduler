class Schedule < ApplicationRecord
  has_many :days, dependent: :destroy
  accepts_nested_attributes_for :days
  validates_associated :days
end

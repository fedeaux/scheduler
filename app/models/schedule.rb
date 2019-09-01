class Schedule < ApplicationRecord
  has_many :days
  accepts_nested_attributes_for :days
  validates_associated :days
end

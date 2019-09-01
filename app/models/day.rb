class Day < ApplicationRecord
  HOUR_REGEX = /\A(([0-9])|([0-1][0-9])|(2[0-3])):[0-5][0-9]\z/

  belongs_to :schedule
  validates :weekday, presence: true, inclusion: 0..6
  validates :start, format: { with: HOUR_REGEX }, allow_blank: true
  validates :finish, format: { with: HOUR_REGEX }, allow_blank: true
  validate :start_and_finish_blank_or_present
  validate :valid_timespan

  def start_and_finish_blank_or_present
    return if (start.blank? && finish.blank?) || (start.present? && finish.present?)
    errors.add :base, "Can't have just start or finish empty"
  end

  def valid_timespan
    return if start.blank? || finish.blank?

    start_minutes = to_minutes start
    finish_minutes = to_minutes finish

    return if start_minutes > finish_minutes
    errors.add :base, "Not a valid timespan"
  end

  def to_minutes(time, pm = false)
    return num if time.blank?
    parts = time.split(':')
    minutes = parts[0].to_i * 60 + parts[1].to_i
    return minutes if minutes > 12*60 or !pm
    minutes + 12*60
  end
end

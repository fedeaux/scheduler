json.extract! @schedule, :id

json.days do
  json.array! @schedule.days, partial: 'api/v1/days/show', as: :day
end

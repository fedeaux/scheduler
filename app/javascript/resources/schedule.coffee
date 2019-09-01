import $ from 'jquery'

export default class Schedule
  index: ->
    $.ajax(
      method: 'get',
      url: "/api/v1/schedules.json",
    )

  get: (schedule_id) ->
    $.ajax(
      method: 'get',
      url: "/api/v1/schedules/#{schedule_id}.json",
    )

  save: (schedule) ->
    adapted_data = @adapt_data schedule
    if adapted_data.schedule.id
      @update adapted_data
    else
      @create adapted_data

  create: (adapted_data) ->
    $.ajax(
      method: 'post',
      url: '/api/v1/schedules.json',
      data: adapted_data
    )

  update: (adapted_data) ->
    $.ajax(
      method: 'put',
      url: "/api/v1/schedules/#{adapted_data.schedule.id}.json",
      data: adapted_data
    )

  adapt_data: (schedule) ->
    schedule = JSON.parse JSON.stringify schedule
    days = schedule.days
    delete schedule.days
    schedule.days_attributes = days
    { schedule: schedule }

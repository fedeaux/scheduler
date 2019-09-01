<template>
  <div>
    <shared-loader :active="loading" />
    <h1 class="scheduler-form-header"> Working Hours:* </h1>
    <div class="ui seven column grid">
      <scheduler-form-day v-for="day in days"
                          :start="day.start"
                          :finish="day.finish"
                          :start_error="day.start_error"
                          :finish_error="day.finish_error"
                          :weekday="day.weekday"
                          :key="day.weekday"
                          @input="update_day"/>
    </div>
    <div class="scheduler-form-actions">
      <button :class="['ui button', { disabled: !at_least_one_valid_timespan }]" @click="apply_to_all"> Apply to all </button>
      <button :class="['ui primary button', { disabled: !valid }]" @click="save"> Save </button>
    </div>
  </div>
</template>

<script lang="coffee">
  import Vue from 'vue'
  import ScheduleResource from '../../resources/schedule'

  export default
    data: ->
      days: []
      inner_schedule: {}
      valid: false
      at_least_one_valid_timespan: false
      loading: false

    props:
      schedule:
        required: true
        type: Object

    methods:
      update_day: (day_attributes) ->
        weekday = day_attributes.weekday

        for name, value of day_attributes
          Vue.set @days[weekday], name, value

        @validate()

      validate: ->
        @valid = true
        @validate_day(day) for day in @days

        for day in @days
          @at_least_one_valid_timespan = day.valid_timespan
          break if @at_least_one_valid_timespan

        @valid = @valid && @at_least_one_valid_timespan

      validate_day: (day) ->
        @validate_time day, 'start'
        @validate_time day, 'finish'
        @validate_timespan day

      validate_time: (day, field) ->
        time = day[field]

        if time == undefined || time == '' || time.match /^(([0-9])|([0-1][0-9])|(2[0-3])):[0-5][0-9]$/
          return @clear_error day, "#{field}_error"

        @set_error day, "#{field}_error", "This does't look like a valid time!"

      validate_timespan: (day) ->
        day.valid_timespan = false

        return if day.start_error or day.finish_error

        start_minutes = @to_minutes day.start
        finish_minutes = @to_minutes day.finish, true

        return if start_minutes == undefined and finish_minutes == undefined

        if start_minutes == undefined
          return @set_error day, 'start_error', 'Please select both times'

        if finish_minutes == undefined
          return @set_error day, 'finish_error', 'Please select both times'

        if finish_minutes <= start_minutes
          @set_error day, 'start_error', 'Not a valid timespan'
          return @set_error day, 'finish_error', true

        day.valid_timespan = true

      set_error: (day, field, error) ->
        Vue.set @days[day.weekday], field, error
        @valid = @valid and error == null

      clear_error: (day, field) ->
        @set_error day, field, null

      to_minutes: (time, pm = false) ->
        return undefined if time == '' or time == undefined
        parts = time.split(':')
        minutes = parseInt(parts[0]) * 60 + parseInt(parts[1])
        return minutes if minutes > 12*60 or !pm
        minutes + 12*60

      apply_to_all: ->
        return unless @at_least_one_valid_timespan
        day_with_valid_timespan = null
        for day in @days
          if day.valid_timespan
            day_with_valid_timespan = day
            break

        for day in @days
          Vue.set day, 'start', day_with_valid_timespan.start
          Vue.set day, 'finish', day_with_valid_timespan.finish

        @validate()

      save: ->
        return unless @valid
        @loading = true
        @inner_schedule.days = @days
        (new ScheduleResource).save(@inner_schedule).then(@saved).fail(@errored).always(@stop_loading)

      saved: (response) ->
        @$router.push path: "/schedules/#{response.schedule_id}"

      errored: ->
        console.log 'errored'

      stop_loading: ->
        @loading = false

    watch:
      schedule: ->
        # Poor's man clone
        @inner_schedule = JSON.parse JSON.stringify @schedule
        @days = @inner_schedule.days
        @validate()
</script>

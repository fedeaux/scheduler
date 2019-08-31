<template>
  <div class="column">
    <shared-error-label v-if="error_message" :message="error_message" position="above" />
    <scheduler-form-hour role="start" v-model="internal_start" />
    <scheduler-form-hour role="end" v-model="internal_end" />

    <div class="ui checkbox">
      <input type="checkbox" v-model="twenty_four_hours" tabindex="-1">
      <label> 24h </label>
    </div>
  </div>
</template>

<script lang="coffee">
  export default
    props: ['start', 'end', 'weekday']

    data: ->
      twenty_four_hours: false
      internal_start: ''
      internal_end: ''
      error_message: false

    methods:
      validate: ->
        start_minutes = @to_minutes @internal_start
        end_minutes = @to_minutes @internal_end, true
        return if start_minutes == undefined and end_minutes == undefined

        if start_minutes == undefined or end_minutes == undefined
          @error_message = 'Please select both times'
        else if end_minutes <= start_minutes
          @error_message = 'Please select times that makes sense'
        else
          @error_message = false
          @$emit 'input', { start: @internal_start, end: @internal_end, weekday: @weekday }

      to_minutes: (time, pm = false) ->
        return undefined if time == '' or time == undefined
        parts = time.split(':')
        minutes = parseInt(parts[0]) * 60 + parseInt(parts[1])
        return time if time > 12*60 or !pm
        time + 12*60

    watch:
      twenty_four_hours: ->
        if @twenty_four_hours
          @internal_start = '00:00'
          @internal_end = '24:00'
        else
          @internal_start = ''
          @internal_end = ''

      internal_start: ->
        @validate()

      internal_end: ->
        @validate()

      start:
        immediate: true
        handler: ->
          @internal_start = @start

      end:
        immediate: true
        handler: ->
          @internal_end = @end

</script>

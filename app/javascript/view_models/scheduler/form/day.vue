<template>
  <div class="column">
    <h4> {{ day_name }} </h4>
    <scheduler-form-hour role="start" :time="start" :error_message="start_error" @input="set_start" />
    <scheduler-form-hour role="finish" :time="finish" :error_message="finish_error"  @input="set_finish" />

    <div class="ui checkbox">
      <input type="checkbox" v-model="twenty_four_hours" tabindex="-1">
      <label> 24h </label>
    </div>
  </div>
</template>

<script lang="coffee">
  import DayNames from '../../../day_names'

  export default
    props: ['start', 'finish', 'start_error', 'finish_error', 'weekday']

    data: ->
      twenty_four_hours: false

    methods:
      set_start: (start) ->
        @emit_input { start: start }

      set_finish: (value) ->
        @emit_input { finish: value }

      emit_input: (attributes) ->
        attributes.weekday = @weekday
        @$emit 'input', attributes

    computed:
      day_name: ->
        DayNames[@weekday]

    watch:
      twenty_four_hours: ->
        if @twenty_four_hours
          @emit_input start: '00:00', finish: '23:59'
        else
          @emit_input start: '', finish: ''
</script>

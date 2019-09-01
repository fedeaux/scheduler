<template>
  <div class="column">
    <scheduler-form-hour role="start" :time="start" :error_message="start_error" @input="set_start" />
    <scheduler-form-hour role="end" :time="end" :error_message="end_error"  @input="set_end" />

    <div class="ui checkbox">
      <input type="checkbox" v-model="twenty_four_hours" tabindex="-1">
      <label> 24h </label>
    </div>
  </div>
</template>

<script lang="coffee">
  export default
    props: ['start', 'end', 'start_error', 'end_error', 'weekday']

    data: ->
      twenty_four_hours: false

    methods:
      set_start: (start) ->
        @emit_input { start: start }

      set_end: (value) ->
        @emit_input { end: value }

      emit_input: (attributes) ->
        attributes.weekday = @weekday
        @$emit 'input', attributes

    watch:
      twenty_four_hours: ->
        if @twenty_four_hours
          @emit_input start: '00:00', end: '24:00'
        else
          @emit_input start: '', end: ''
</script>

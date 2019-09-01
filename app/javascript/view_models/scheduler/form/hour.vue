<template>
  <div :class="['ui fluid', { error: !!error_message } ,'input']">
    <shared-error-label v-if="show_error_on_top" :message="error_message" position="above" />
    <input type="text" v-model="internal_time" @blur="emit_input" />
    <shared-error-label v-if="show_error_below" :message="error_message" position="below" />
  </div>
</template>

<script lang="coffee">
  export default
    model:
      prop: 'time'

    data: ->
      internal_time: ''

    props:
      error_message:
        default: false

      time:
        default: ''

      role:
        required: true
        validator: (role) ->
          role in ['start', 'end']

    methods:
      emit_input: ->
        @$emit 'input', @internal_time

    computed:
      show_error_on_top: ->
        @error_message && @role == 'start'

      show_error_below: ->
        @error_message && @role == 'end'

    watch:
      time:
        immediate: true
        handler: ->
          @internal_time = @time

</script>

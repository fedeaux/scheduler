<template>
  <div :class="['ui fluid', { error: !!internal_error_message } ,'input']">
    <shared-error-label v-if="show_error_on_top" :message="internal_error_message" position="above" />
    <input type="text" v-model="internal_time" @blur="emit_input" @input="clear_internal_error_message" />
    <shared-error-label v-if="show_error_below" :message="internal_error_message" position="below" />
  </div>
</template>

<script lang="coffee">
  export default
    model:
      prop: 'time'

    data: ->
      internal_error_message: ''
      internal_time: ''

    props:
      error_message:
        default: false

      time:
        default: ''

      role:
        required: true
        validator: (role) ->
          role in ['start', 'finish']

    methods:
      emit_input: ->
        @$emit 'input', @internal_time

      clear_internal_error_message: ->
        @internal_error_message = null

    computed:
      show_error_on_top: ->
        @internal_error_message && @role == 'start'

      show_error_below: ->
        @internal_error_message && @role == 'finish'

    watch:
      error_message:
        immediate: true
        handler: ->
          @internal_error_message = @error_message

      time:
        immediate: true
        handler: ->
          @internal_time = @time

</script>

<template>
  <div :class="['ui fluid', { error: !!error_message } ,'input']">
    <shared-error-label v-if="show_error_on_top" :message="error_message" position="above" />
    <input type="text" v-model="internal_time" @blur="validate" @input="error_message= false" />
    <shared-error-label v-if="show_error_below" :message="error_message" position="below" />
  </div>
</template>

<script lang="coffee">
  export default
    model:
      prop: 'time'

    data: ->
      internal_time: ''
      error_message: false

    props:
      time:
        default: ''

      role:
        required: true
        validator: (role) ->
          role in ['start', 'end']

    methods:
      validate: ->
        if @internal_time == '' || @internal_time.match /^(([0-9])|([0-1][0-9])|(2[0-4])):[0-5][0-9]$/
          @error_message = false
          return @$emit 'input', @internal_time

        @error_message = "This does't look like a valid time!"

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

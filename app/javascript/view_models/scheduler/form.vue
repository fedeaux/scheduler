<template>
  <div>
    <h1 class="scheduler-form-header"> Working Hours:* </h1>
    <div class="ui seven column grid">
      <scheduler-form-day v-for="day in days"
                          :weekday="day.weekday"
                          :start="day.start"
                          :end="day.end"
                          @input="propagate"/>
    </div>
    <div class="scheduler-form-actions">
      <button class="ui button"> Apply to all </button>
      <button class="ui primary button"> Save </button>
    </div>
  </div>
</template>

<script lang="coffee">
  export default
    props:
      days:
        required: true
        type: Array

    methods:
      propagate: (value) ->
        @$emit 'input', value

</script>

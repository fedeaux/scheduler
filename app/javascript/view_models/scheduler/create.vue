<template>
  <div class="scheduler">
    <scheduler-form :initial_days="days" />
  </div>
</template>

<script lang="coffee">
  import Vue from 'vue'

  export default
    data: ->
      days: []
      error: false

    mounted: ->
      days = []

      for weekday in [0..6]
         days[weekday] = { weekday: weekday, start: '', end: '', start_error: null, end_error: null }

      Vue.set @, 'days', days
</script>

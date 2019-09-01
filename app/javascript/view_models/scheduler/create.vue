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

    mounted: ->
      days = []

      for weekday in [0..6]
         days[weekday] = { weekday: weekday, start: '', finish: '', start_error: null, finish_error: null }

      Vue.set @, 'days', days
</script>

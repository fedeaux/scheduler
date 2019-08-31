<template>
  <div class="scheduler">
    <scheduler-form :days="days" @input="set_day" />
  </div>
</template>

<script lang="coffee">
  import Vue from 'vue'

  export default
    data: ->
      days: []

    methods:
      set_day: (day) ->
        Vue.set @days, day.weekday, day

    created: ->
      for weekday in [0..6]
        Vue.set @days, weekday, { weekday: weekday, start: '', end: '' }
</script>

<template>
  <div class="scheduler">
    <scheduler-form :schedule="schedule" />
  </div>
</template>

<script lang="coffee">
  import Vue from 'vue'
  import ScheduleResource from '../../resources/schedule'

  export default
    data: ->
      schedule: {}

    methods:
      set_schedule: (data) ->
        Vue.set @, "schedule", data

    created: ->
      @loading = true
      (new ScheduleResource).get(@$route.params.schedule_id).then(@set_schedule).always( => @loading = false )
</script>

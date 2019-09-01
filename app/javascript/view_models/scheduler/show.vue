<template>
  <div class="scheduler-show">
    <table class="ui table">
      <tr v-for="day in days">
        <td>{{ day.weekday }}</td>
        <td>{{ day.start }}</td>
        <td>{{ day.finish }}</td>
      </tr>
    </table>

    <router-link class="ui primary button" :to="edit_path"> Edit </router-link>
    <router-link class="ui button" :to="new_path"> New </router-link>
  </div>
</template>

<script lang="coffee">
  import ScheduleResource from '../../resources/schedule'
  import Vue from 'vue'

  export default
    data: ->
      days: []

    methods:
      set_schedule: (data) ->
        Vue.set @, 'days', data.days

    computed:
      edit_path: ->
        "/schedules/#{@$route.params.schedule_id}/edit"

      new_path: ->
        "/"

    created: ->
      (new ScheduleResource).get(@$route.params.schedule_id).then @set_schedule
</script>

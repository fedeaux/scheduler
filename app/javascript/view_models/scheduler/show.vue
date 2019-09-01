<template>
  <div class="scheduler-show">
    <shared-loader :active="loading" />

    <table class="ui table">
      <tr v-for="day in days">
        <td>{{ days_names[day.weekday] }}</td>
        <td v-if="day.start" >{{ day.start }}</td>
        <td v-if="day.start" >{{ day.finish }}</td>
        <td colspan="2" v-else > unavailable </td>
      </tr>
    </table>

    <router-link class="ui primary button" :to="edit_path"> Edit </router-link>
    <router-link class="ui button" :to="new_path"> New </router-link>
    <router-link class="ui button" :to="index_path"> All </router-link>
  </div>
</template>

<script lang="coffee">
  import ScheduleResource from '../../resources/schedule'
  import Vue from 'vue'
  import DayNames from '../../day_names'

  export default
    data: ->
      days: []
      loading: false
      days_names: DayNames

    methods:
      set_schedule: (data) ->
        Vue.set @, 'days', data.days

    computed:
      edit_path: ->
        "/schedules/#{@$route.params.schedule_id}/edit"

      new_path: ->
        "/schedules/new"

      index_path: ->
        "/"

    created: ->
      @loading = true
      (new ScheduleResource).get(@$route.params.schedule_id).then(@set_schedule).always( => @loading = false )
</script>

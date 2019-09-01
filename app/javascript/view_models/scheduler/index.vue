<template>
  <div class="scheduler-show">
    <shared-loader :active="loading" />

    <table class="ui table" v-if="schedules.length > 0">
      <tr v-for="schedule in schedules">
        <td>
          <router-link :to="show_path(schedule.id)"> Schedule {{ schedule.id }} </router-link>
        </td>
      </tr>
    </table>

    <div class="ui big message" v-else>
      No Schedules Yet!
    </div>

    <router-link class="ui button" :to="new_path"> New </router-link>
  </div>
</template>

<script lang="coffee">
  import ScheduleResource from '../../resources/schedule'
  import Vue from 'vue'
  import DayNames from '../../day_names'

  export default
    data: ->
      schedules: []
      loading: false

    methods:
      set_schedules: (data) ->
        Vue.set @, 'schedules', data.schedules

      show_path: (schedule_id) ->
        "/schedules/#{schedule_id}"

    computed:
      new_path: ->
        "/schedules/new"

    created: ->
      @loading = true
      (new ScheduleResource).index().then(@set_schedules).always( => @loading = false )
</script>

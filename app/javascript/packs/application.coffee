import Vue from 'vue'
import App from '../view_models/app.vue'
import VueRouter from 'vue-router'
Vue.use(VueRouter)

SchedulerCreate = require('../view_models/scheduler/create').default
SchedulerShow = require('../view_models/scheduler/show').default
SchedulerEdit = require('../view_models/scheduler/edit').default

Vue.component 'scheduler-form', require('../view_models/scheduler/form').default
Vue.component 'scheduler-form-day', require('../view_models/scheduler/form/day').default
Vue.component 'scheduler-form-hour', require('../view_models/scheduler/form/hour').default
Vue.component 'shared-error-label', require('../view_models/shared/error/label').default
Vue.component 'shared-loader', require('../view_models/shared/loader').default

router = new VueRouter
  mode: 'history'
  routes: [
    { path: '', component: SchedulerCreate }
    { path: '/', component: SchedulerCreate }
    { path: '/schedules/:schedule_id', component: SchedulerShow }
    { path: '/schedules/:schedule_id/edit', component: SchedulerEdit }
  ]

document.addEventListener 'DOMContentLoaded', ->
  app = new Vue({
    router: router
    render: (h) => h(App)
  }).$mount()

  document.body.appendChild app.$el

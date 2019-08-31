import Vue from 'vue'
import App from '../view_models/app.vue'

Vue.component 'scheduler-create', require('../view_models/scheduler/create').default
Vue.component 'scheduler-form', require('../view_models/scheduler/form').default
Vue.component 'scheduler-form-day', require('../view_models/scheduler/form/day').default
Vue.component 'scheduler-form-hour', require('../view_models/scheduler/form/hour').default
Vue.component 'shared-error-label', require('../view_models/shared/error/label').default

document.addEventListener 'DOMContentLoaded', ->
  app = new Vue({
    render: (h) => h(App)
  }).$mount()

  document.body.appendChild app.$el

import Vue from 'vue'
import App from '../view_models/app.vue'

document.addEventListener 'DOMContentLoaded', ->
  app = new Vue({
    render: (h) => h(App)
  }).$mount()

  document.body.appendChild app.$el

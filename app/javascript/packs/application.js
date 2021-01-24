// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()
// require("channels")

import Vue from 'vue'
import App from '../app.vue'
import router from './router'
import vuetify from './vuetify'
// import scrollto from './scrollto'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('app'))
  const app = new Vue({
    router,
    el,
    vuetify,
    // scrollto,
    render: h => h(App)
  })
  console.log(vuetify)

  // console.log(app)
})
Vue.config.devtools = true;

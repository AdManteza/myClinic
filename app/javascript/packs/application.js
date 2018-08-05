/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// console.log('Hello World from Webpacker')

// import Vue from 'vue'
// // import App from '../app.vue'
// import Calendar from './components/calendar.vue'
// import BootstrapVue from 'bootstrap-vue'
// import 'bootstrap/dist/css/bootstrap.css'
// import 'bootstrap-vue/dist/bootstrap-vue.css'

// import VCalendar from 'v-calendar';
// import 'v-calendar/lib/v-calendar.min.css';

// console.log(VCalendar)

// Vue.use(BootstrapVue)

// Vue.use(VCalendar, {
//   formats: {
//     title: 'MMMM YYYY',
//     weekdays: 'W',
//     navMonths: 'MMM',
//     input: ['L', 'YYYY-MM-DD', 'YYYY/MM/DD'],
//     dayPopover: 'L',
//   }
// })

// document.addEventListener('DOMContentLoaded', () => {
//   const el = document.body.appendChild(document.createElement('hello'))
//   const app = new Vue({
//     el,
//     render: h => h(Calendar)
//   })

//   console.log(app)
// })

import Vue from 'vue/dist/vue.esm'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import App from './app.vue'

Vue.use(ElementUI)

new Vue({
  el: '#app',
  render: h => h(App)
})

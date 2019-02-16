/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Vue Yo!
import Vue from 'vue/dist/vue.esm'

// Turbolinks
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

// Talk to the backend
import VueResource from 'vue-resource'
Vue.use(VueResource)

// Bootstrap-Vue
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import BootstrapVue from 'bootstrap-vue'
Vue.use(BootstrapVue)

// Calendar
import VueCal from 'vue-cal'
Vue.component('vue_cal', VueCal)

// My Components
// ..Common components
import LoginForm from '../common/login_form.vue'
Vue.component('login_form', LoginForm)

// ..Application components
import AdminNavBar from '../application/admin_navbar.vue'
Vue.component('admin_navbar', AdminNavBar)

// ..Users components
import UserIndex from '../users/index.vue'
Vue.component('user_index', UserIndex)

// ..Appointments components
import AppointmentForm from '../appointments/form.vue'
Vue.component('appointment_form', AppointmentForm)

// ..Appointments components
import PatientSessionForm from '../patient_sessions/form.vue'
Vue.component('patient_session_form', PatientSessionForm)

// Global events
Vue.prototype.$eventHub = new Vue()

document.addEventListener('turbolinks:load', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  const app = new Vue({
    el: '[data-behavior="vue"]'
  })
})

/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// Turbolinks
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

// Pre-fabricated Components
import VueResource from 'vue-resource'
import ValidationMixin from 'vuelidate'
Vue.use(VueResource)
Vue.use(ValidationMixin)

// Bootstrap-Vue
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
Vue.use(BootstrapVue)

// My Components
import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import UserForm from '../user_form.vue'

Vue.component('app', App)

document.addEventListener('turbolinks:load', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  const app = new Vue({
    el: '[data-behavior="vue"]',
    components: {
      user_form: UserForm
    }
  })
})

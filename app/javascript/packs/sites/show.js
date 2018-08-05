import Vue from 'vue/dist/vue.esm'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

import SitesShow from 'views/sites/show.vue'

Vue.use(ElementUI)

new Vue({
  el: '#sites-show',
  components: {
    'sites-show': SitesShow
  }
})

import Vue from 'vue'
import Router from 'vue-router'
// import BootstrapVue from 'bootstrap-vue'
import TopPage from '@/components/TopPage'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'TopPage',
      component: TopPage
    }
  ]
})

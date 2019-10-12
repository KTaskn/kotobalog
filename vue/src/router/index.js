import Vue from 'vue'
import Router from 'vue-router'
import BootstrapVue from 'bootstrap-vue'
// import TopPage from '@/components/TopPage'
// import SignupPage from '@/components/SignupPage'
// import NotePage from '@/components/NotePage'
import ManagerPage from '@/components/ManagerPage'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(Router)
Vue.use(BootstrapVue)

export default new Router({
  routes: [
    // {
    //   path: '/',
    //   name: 'TopPage',
    //   component: TopPage
    // },
    // {
    //   path: '/signup',
    //   name: 'SignupPage',
    //   component: SignupPage
    // },
    // {
    //   path: '/note',
    //   name: 'NotePage',
    //   component: NotePage
    // }
    {
      path: '/',
      name: 'ManagerPage',
      component: ManagerPage
    }
  ]
})

import Vue from 'vue'
import Router from 'vue-router'
import EventHub from '@/global/EventHub'
import BootstrapVue from 'bootstrap-vue'
import TopPage from '@/components/TopPage'
import SignupPage from '@/components/SignupPage'
import SigninPage from '@/components/SigninPage'
import NotePage from '@/components/NotePage'
import ManagerPage from '@/components/ManagerPage'
import 'vue-awesome/icons/edit'
import 'vue-awesome/icons/clipboard'
import 'vue-awesome/icons/sign-out-alt'
import Icon from 'vue-awesome/components/Icon'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(Router)
Vue.use(BootstrapVue)
Vue.use(EventHub)

// アイコンモジュール
Vue.component('v-icon', Icon)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'TopPage',
      component: TopPage
    },
    {
      path: '/signup',
      name: 'SignupPage',
      component: SignupPage
    },
    {
      path: '/signin',
      name: 'SigninPage',
      component: SigninPage
    },
    {
      path: '/note',
      name: 'NotePage',
      component: NotePage
    },
    {
      path: '/manager',
      name: 'ManagerPage',
      component: ManagerPage
    }
  ]
})

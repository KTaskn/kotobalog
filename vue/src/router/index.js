import Vue from 'vue'
import Router from 'vue-router'
import EventHub from '@/global/EventHub'
import BootstrapVue from 'bootstrap-vue'
import 'vue-awesome/icons'
import Icon from 'vue-awesome/components/Icon'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

const TopPage = () => import('@/components/TopPage')
const SignupPage = () => import('@/components/SignupPage')
const SigninPage = () => import('@/components/SigninPage')
const NotePage = () => import('@/components/NotePage')
const ManagerPage = () => import('@/components/ManagerPage')

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

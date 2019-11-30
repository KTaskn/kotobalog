import Vue from 'vue'
import Router from 'vue-router'
import EventHub from '@/global/EventHub'
import TopPage from '@/components/TopPage'
import SignupPage from '@/components/SignupPage'
import SigninPage from '@/components/SigninPage'
import NotePage from '@/components/NotePage'
import ManagerPage from '@/components/ManagerPage'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import {
  BNavbar, BNavbarBrand, BNavbarNav, BNavItem, BNavItemDropdown,
  BForm, BFormGroup, BFormInput,
  BButton, BCard, BCardText,
  BContainer, BCol, BRow, BCollapse,
  BTooltip, TooltipPlugin, DropdownPlugin, BFormTextarea,
  VBToggle
} from 'bootstrap-vue'
Vue.component('b-navbar', BNavbar)
Vue.component('b-navbar-brand', BNavbarBrand)
Vue.component('b-navbar-nav', BNavbarNav)
Vue.component('b-nav-item', BNavItem)
Vue.component('b-nav-item-dropdown', BNavItemDropdown)
Vue.use(DropdownPlugin)
Vue.component('b-form', BForm)
Vue.component('b-form-group', BFormGroup)
Vue.component('b-form-input', BFormInput)
Vue.component('b-button', BButton)
Vue.component('b-card', BCard)
Vue.component('b-card-text', BCardText)
Vue.component('b-container', BContainer)
Vue.component('b-col', BCol)
Vue.component('b-row', BRow)
Vue.component('b-collapse', BCollapse)
Vue.component('b-tooltip', BTooltip)
Vue.component('b-form-textarea', BFormTextarea)
Vue.use(TooltipPlugin)
Vue.directive('b-toggle', VBToggle)

Vue.use(Router)
Vue.use(EventHub)

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

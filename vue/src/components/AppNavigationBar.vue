<template>
  <div>
    <b-navbar id="navbar" type="dark" variant="info">
      <b-navbar-brand to="/">{{ app_name }}</b-navbar-brand>
      <b-navbar-nav>
        <b-nav-item to="/note">Note</b-nav-item>
        <b-nav-item to="/manager">Manager</b-nav-item>
        <b-nav-item v-on:click="signout" v-if="flag_show_signout" left>Signout</b-nav-item>
      </b-navbar-nav>
    </b-navbar>
  </div>
</template>

<script>
// import axios from 'axios'
import Global from '@/global/index'

export default {
  name: 'NavigationBar',
  data () {
    return {
      app_name: Global.APP_NAME,
      flag_show_signout: false
    }
  },
  mounted () {
    if (localStorage.access_token) {
      this.raise_show_signout()
    } else {
      this.drop_show_signout()
    }
    this.$eventHub.$on('raise_show_signout', this.raise_show_signout)
    this.$eventHub.$on('drop_show_signout', this.drop_show_signout)
  },
  methods: {
    signout () {
      if (localStorage.access_token) {
        this.post_signout('/user/signout')
      }
    },
    post_signout (url) {
      return Global.post_wrapper(url).then((res) => {
        localStorage.removeItem('name')
        localStorage.removeItem('access_token')
        localStorage.removeItem('refresh_token')
        this.$router.push({ path: '/' })
        this.drop_show_signout()
      })
    },
    raise_show_signout () {
      console.log('raise')
      this.flag_show_signout = true
    },
    drop_show_signout () {
      console.log('drop')
      this.flag_show_signout = false
    }
  }
}
</script>

<style scoped>
#navbar {
  background: #8C4F49!important;
}
</style>

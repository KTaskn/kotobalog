<template>
  <div>
    <b-navbar type="dark" variant="info">
      <b-navbar-brand to="/">{{ app_name }}</b-navbar-brand>
      <b-navbar-nav>
        <b-nav-item to="/note">Note</b-nav-item>
        <b-nav-item to="/manager">Manager</b-nav-item>
        <b-nav-item v-on:click="signout" left>ログアウト</b-nav-item>
      </b-navbar-nav>
    </b-navbar>
  </div>
</template>

<script>
import axios from 'axios'
import Global from '@/global/index'
export default {
  name: 'NavigationBar',
  data () {
    return {
      app_name: Global.APP_NAME
    }
  },
  methods: {
    signout () {
      this.post_signout('/user/signout')
    },
    post_signout (url) {
      return axios.post(
        Global.API_URL + url,
        {
          name: localStorage.name,
          access_token: localStorage.access_token
        },
        {
          headers: {
            'Content-Type': 'application/json'
          }
        }
      ).then((res) => {
        localStorage.removeItem('name')
        localStorage.removeItem('access_token')
        localStorage.removeItem('refresh_token')
        this.$router.push({ path: '/' })
      })
    }
  }
}
</script>

<style scoped>
#app-navbar {
  background: #95a5a6
}
</style>

<template>
  <div>
    <b-navbar id="navbar" type="dark">
      <b-navbar-brand to="/">{{ app_name }}</b-navbar-brand>
      <b-navbar-nav class="ml-auto">
        <b-nav-item-dropdown text="メニュー" v-if="flag_show_signout" right>
          <b-dropdown-item to="/note">記録する</b-dropdown-item>
          <b-dropdown-item to="/manager">一覧をみる</b-dropdown-item>
          <b-dropdown-item v-on:click="signout">サインアウト</b-dropdown-item>
        </b-nav-item-dropdown>
        <b-nav-item v-on:click="signin" v-if="!flag_show_signout" right>
          サインイン
        </b-nav-item>
        <b-nav-item v-on:click="signup" v-if="!flag_show_signout" right>
          登録
        </b-nav-item>
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
    signin () {
      this.$router.push({ path: '/signin' })
    },
    signup () {
      this.$router.push({ path: '/signup' })
    },
    raise_show_signout () {
      this.flag_show_signout = true
    },
    drop_show_signout () {
      this.flag_show_signout = false
    }
  }
}
</script>

<style scoped>
#navbar {
  background-color: #dfcf86;
}
</style>

<template>
  <div>
    <b-navbar id="navbar" type="dark">
      <b-navbar-brand to="/">{{ app_name }}</b-navbar-brand>
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
  },
  methods: {
  }
}
</script>

<style scoped>
#navbar {
  background-color: #dfcf86;
}
</style>

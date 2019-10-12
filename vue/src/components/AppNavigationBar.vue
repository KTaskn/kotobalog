<template>
  <div>
    <b-navbar type="dark" variant="info">
      <b-navbar-brand to="/">{{ app_name }}</b-navbar-brand>
      <b-navbar-nav>
        <b-nav-item to="/note">Note</b-nav-item>
        <b-nav-item to="/manager">Manager</b-nav-item>
      </b-navbar-nav>
    </b-navbar>
  </div>
</template>

<script>
import Global from '@/global/index'
export default {
  name: 'NavigationBar',
  data () {
    return {
      app_name: Global.APP_NAME
    }
  }
}
</script>

<style scoped>
#app-navbar {
  background: #95a5a6
}
</style>

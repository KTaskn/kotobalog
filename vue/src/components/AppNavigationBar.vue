<template>
  <div>
    <nav class="navbar" id="app-navbar">{{ app_name }}</nav>
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

<template>
  <div id="app">
    <AppNavigationBar></AppNavigationBar>
    <router-view/>
  </div>
</template>

<script>
import AppNavigationBar from './components/AppNavigationBar'
export default {
  name: 'App',
  components: {
    AppNavigationBar
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>

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
html {
    height: 100%;
}
body {
    height: 100%;
    margin: 0;
}
#app {
  height: 100%;
  margin: 0;
  font-family: 'Hiragino Kaku Gothic Pro', 'ヒラギノ角ゴ Pro W3', 'メイリオ', 'Meiryo', 'ＭＳ Ｐゴシック', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #40bfc1!important;
  background-color: #f5f0e3;
}
.btn-primary, .btn-primary:hover, .btn-primary:active, .btn-primary:visited {
    background-color: #ff6f5e !important;
    border-color: #ff6f5e;
}
#memo_colors {
color: #f0134d,
#ff6f5e,
#f5f0e3,
#40bfc1
}
</style>

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
    background-color: #dfcf86;
}
#app {
  font-family: 'Hiragino Kaku Gothic Pro', 'ヒラギノ角ゴ Pro W3', 'メイリオ', 'Meiryo', 'ＭＳ Ｐゴシック', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #212121!important;
  background-color: #dfcf86;
}
.btn-primary, .btn-primary:hover, .btn-primary:active, .btn-primary:visited {
    background-color: #641214 !important;
    border-color: #dfcf86;
}
#memo_colors {
color: #273379, #dfcf86
}
</style>

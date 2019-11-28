<template>
  <div id="app">
    <AppNavigationBar></AppNavigationBar>
    <router-view/>
  </div>
</template>

<script>
const AppNavigationBar = () => import('@/components/AppNavigationBar')
export default {
  name: 'App',
  components: {
    AppNavigationBar
  }
}
</script>

<style>

html {
    background-color: #D7CCC8;
}
body {
    background-color: #D7CCC8;
}
#app {
  font-family: 'Hiragino Kaku Gothic Pro', 'ヒラギノ角ゴ Pro W3', 'メイリオ', 'Meiryo', 'ＭＳ Ｐゴシック', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #212121!important;
  background-color: #D7CCC8;
}
.btn-primary, .btn-primary:hover, .btn-primary:active, .btn-primary:visited {
    background-color: #FF5252 !important;
    border-color: #FF5252;
}
#memo_colors {
color: #795548,  /* primary */
#5D4037, /* dark primary */
#D7CCC8, /* light primary */
#FFFFFF, /* text */
#FF5252, /* accent */
#212121, /* primary text */
#757575, /* secondary text */
#BDBDBD /* divider */
}
</style>

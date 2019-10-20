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
@import url('https://fonts.googleapis.com/css?family=Noto+Serif+JP&display=swap');

/* html {
    background-color: #f5f0e3;
}
body {
    background-color: #f5f0e3;
} */
#app {
  font-family: 'Noto Serif JP', 'Hiragino Kaku Gothic Pro', 'ヒラギノ角ゴ Pro W3', 'メイリオ', 'Meiryo', 'ＭＳ Ｐゴシック', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #212121!important;
  background-color: #D7CCC8;
}
.btn-primary, .btn-primary:hover, .btn-primary:active, .btn-primary:visited {
    background-color: #BDBDBD !important;
    border-color: #BDBDBD;
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

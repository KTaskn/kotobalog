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
  font-family: 'Hiragino Kaku Gothic Pro', 'ヒラギノ角ゴ Pro W3', 'メイリオ', 'Meiryo', 'ＭＳ Ｐゴシック', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #0D0D0D!important;
}
#memo_colors {
color: #8C8C88,
#BFBFBD,
#D99282,
#8C4F49,
#0D0D0D,
}
</style>

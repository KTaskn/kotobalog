<template>
  <b-container fluid id="topheader" :style="{ 'background-image': 'url(' + backgroundImageSrc + ')' }">
    <b-row id="topheader-text" align-v="center">
      <b-col offset="2" cols="8">
        <h1 class="text-left">コトバをためる</h1>
        <p class="text-left">コトバノートは小説やポエムの一節、または偉人の名言、街角の看板、いろいろなところに書かれたコトバを記録するためのサービスです。</p>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  data () {
    return {
      backgroundImageSrc: './assets/top-header-pattern.png'
    }
  }
}
</script>

<style scoped>
#topheader {
  background-size: 25%;
  opacity: 0.8;
}
#topheader-text {
  background: rgba(240, 19, 114, 0.3);
  color: #ffffff;
  height: 300px;
}
</style>

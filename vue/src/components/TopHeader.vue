<template>
    <b-container fluid id="topheader" :style="{'background-image': 'url(' + backgroundImageSrc + ')'}">
    <b-row id="topheader-text" align-v="center">
      <b-col cols="12">
        <h1 class="text-left">コトバをためる</h1>
        <p class="text-left">コトバノートは小説やポエムの一節、または偉人の名言、街角の看板、あなたの心にのこったコトバを記録するためのサービスです。</p>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  data () {
    return {
      backgroundImageSrc: './assets/header.jpg'
    }
  }
}
</script>

<style scoped>
#topheader {
  color: #ffffff;
  background-size: cover;
  background-color:#D7CCC8;
}
#topheader-text {
  background: rgba(240, 19, 114, 0.3);
  color: #ffffff;
  height: 300px;
}
</style>

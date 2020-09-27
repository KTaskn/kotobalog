<template>
    <b-container fluid id="topheader">
    <b-row id="topheader-text" align-v="center">
      <b-col offset="1">
        <h2 class="text-left">コトバをためる</h2>
        <p class="text-left">コトバノートは小説やポエムの一節、または偉人の名言、街角の看板、あなたの心にのこったコトバを記録するためのサービスです。</p>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Global from '@/global/index'
export default {
  methods: {
    callTwitterOAuth () {
      this.get_twitterOAuth('/user/twitteroauth')
    },
    get_twitterOAuth (url) {
      return Global.get_wrapper(
        url
      ).then((res) => {
        if (res.data.result) {
          window.location = res.data.oauth_url
        } else {
          this.$eventHub.$emit('drop_show_signout')
          this.haserror = true
        }
      })
    }
  }
}
</script>

<style scoped>
#topheader {
  padding-top:10px;
  padding-bottom:10px;
}
</style>

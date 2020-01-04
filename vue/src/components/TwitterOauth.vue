<template>
  <div class="container">
    <b-card class="card-twitteroauth">
      <b-card-body>
        <b-card-sub-title>処理中です。</b-card-sub-title>
      </b-card-body>
    </b-card>
  </div>
</template>

<script>
export default {
  mounted () {
    console.log(this.$route.query.oauth_token)
    console.log(this.$route.query.oauth_verifier)
  }
}
</script>

<style scoped>
</style>

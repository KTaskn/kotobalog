<template>
  <b-card class="sentence-card" :title="card.sentence" :sub-title="card.creator">
  </b-card>
</template>

<script>
export default {
  props: ['sentence'],
  mounted () {
    console.log(this.sentence)
  },
  data () {
    return {
      card: {
        sentence: '"' + this.sentence.sentence + '"',
        creator: this.sentence.creator
      }
    }
  }
}
</script>

<style scoped>
</style>

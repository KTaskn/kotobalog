<template>
  <b-card class="sentence-card" :title="card.sentence" :sub-title="card.creator">
    <b-card-text v-if=show_text>{{ card.publisher }} {{ card.title }}</b-card-text>
    <a class="twitter-share-button" v-bind:href="card.tweet_text">Tweet</a>
  </b-card>
</template>

<script>
export default {
  props: ['sentence'],
  mounted () {
    if (this.sentence.title || this.sentence.publisher) {
      this.show_text = true
    }
  },
  data () {
    return {
      card: {
        sentence: '"' + this.sentence.sentence + '"',
        creator: this.sentence.creator,
        publisher: this.sentence.publisher,
        title: this.sentence.title,
        tweet_text: 'https://twitter.com/intent/tweet?text=' + this.sentence.sentence + ' - ' + this.sentence.creator + ' コトバノートで記録しました。'
      },
      show_text: false
    }
  }
}
</script>

<style scoped>
</style>

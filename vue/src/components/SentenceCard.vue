<template>
  <b-card class="sentence-card" :title="card.sentence" :sub-title="card.creator">
    <b-card-text v-if=show_text>{{ card.publisher }} {{ card.title }}</b-card-text>
    <b-button id="tweet-button" v-on:click="popUpTweetWindow" size="sm">ツイート</b-button>
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
        title: this.sentence.title
      },
      show_text: false
    }
  },
  methods: {
    format_tweet_text (text, creator) {
      if (text.length > 100) {
        return '' + text.substring(0, 100) + '...' + ' - ' + creator
      } else {
        return '' + text + ' - ' + creator
      }
    },
    popUpTweetWindow () {
      const url = encodeURI(
        'https://twitter.com/intent/tweet?text=' +
        this.format_tweet_text(this.sentence.sentence, this.sentence.creator) +
        ' ＠コトバノートで記録しました。' +
        ' https://kotobanote.jp/'
      )
      const option = 'status=1,width=818,height=400,top=100,left=100'
      window.open(url, 'twitter', option)
    }
  }
}
</script>

<style scoped>
#tweet-button {
  background-color: #00acee;
  border-color: #00acee;
  font: normal normal normal 11px/18px 'Helvetica Neue',Arial,sans-serif;
}
</style>

<template>
  <b-card
    no-body
    class="timeline-card"
    >
    <b-card-body>
      <b-card-title>
        {{ card.sentence }}
      </b-card-title>
      <b-card-sub-title>
        {{ card.creator }}
      </b-card-sub-title>
      <b-card-text v-if="show_text">{{ card.publisher }} {{ card.title }}</b-card-text>
    </b-card-body>
    <b-card-footer class="text-left">
      <div v-on:click="like">
        <v-icon name="heart" color="#f00" scale="1" v-if="card.likeit"/>
        <v-icon name="regular/heart" scale="1" v-else/>
        <span id="likeit">
          {{ card.likenum }}
        </span>
        <b-button id="tweet-button" v-on:click="popUpTweetWindow" size="sm">ツイート</b-button>
      </div>
    </b-card-footer>
  </b-card>
</template>

<script>
import Global from '@/global/index'
export default {
  props: ['sentence'],
  mounted () {
    this.get_islike()
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
        likenum: this.sentence.likenum,
        likeit: false,
        waiting_process_islike: false
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
    },
    get_islike () {
      this.waiting_process_islike = true
      this.get_request_islike('/sentence/islike')
    },
    get_request_islike (url) {
      return Global.get_wrapper(
        url,
        {
          sentence_id: this.sentence.id
        }
      ).then((res) => {
        if (res.data.result) {
          this.card.likeit = res.data.islike
          this.card.likenum = res.data.likenum

          this.waiting_process_islike = false
        } else {
        }
      })
    },
    like () {
      if (this.waiting_process_islike === false) {
        this.post_request_like('/sentence/like')
      }
    },
    post_request_like (url) {
      return Global.post_wrapper(
        url,
        {
          sentence_id: this.sentence.id
        }
      ).then((res) => {
        if (res.data.result) {
          this.card.likeit = res.data.islikes
          this.get_islike()
        } else {
        }
      })
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

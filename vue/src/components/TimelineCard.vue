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
      <b-card-text>{{ card.comment }}</b-card-text>
    </b-card-body>
    <b-card-footer class="text-left">
      <div class="footer-entity">
        <font-awesome-icon :icon="['fab', 'twitter']" color="#00acee" size="1x" v-on:click="popUpTweetWindow"/>
      </div>
      <div v-on:click="like">
        <font-awesome-icon :icon="['fas', 'heart']" color="#f00" size="1x" v-if="card.likeit" />
        <font-awesome-icon :icon="['far', 'heart']" size="1x" v-else/>
        <span id="likeit">
          {{ card.likenum }}
        </span>
      </div>
    </b-card-footer>
  </b-card>
</template>

<script>
import Global from '@/global/index'
export default {
  props: ['sentence'],
  mounted () {
    if (localStorage.access_token) {
      this.get_islike()
    }
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
        comment: this.sentence.comment,
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
        this.format_tweet_text(this.card.sentence, this.card.creator) +
        ' ＠コトバノートから' +
        ' https://kotobanote.jp/'
      )
      const option = 'status=1,width=818,height=400,top=100,left=100'
      window.open(url, 'twitter', option)
    },
    like () {
      if (localStorage.access_token && this.waiting_process_islike === false) {
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
    }
  }
}
</script>

<style scoped>
#likeit {
  display: inline-block;
  vertical-align: -0.1em;
  width: 5em;
  text-align: left;
}
.footer-entity {
  float: left;
  margin-right: 0.5em;
}
</style>

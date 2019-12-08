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
        likeit: false,
        waiting_process_islike: false
      },
      show_text: false
    }
  },
  methods: {
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
</style>

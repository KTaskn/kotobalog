<template>
  <div class="container">
    <h1 class="text-left">みんなの記録</h1>
    <TimelineCard
      class="timelinecard"
      v-for="a_sentence in l_sentence"
      v-bind:key="a_sentence.id"
      v-bind:sentence="a_sentence"></TimelineCard>
  </div>
</template>

<script>
import Global from '@/global/index'
import axios from 'axios'
import TimelineCard from '@/components/TimelineCard'
export default {
  mounted () {
    this.get_timeline()
  },
  data () {
    return {
      l_sentence: [
      ]
    }
  },
  components: {
    TimelineCard
  },
  methods: {
    get_timeline () {
      this.get_note('/timeline/get')
    },
    get_note (url, data = {}) {
      return axios.get(
        Global.API_URL + url
      ).then((res) => {
        if (res.data.result) {
          this.l_sentence = res.data.sentences
        } else {
        }
      })
    }
  }
}
</script>

<style scoped>
h1 {
  font-size: 1.5rem;
}
.container {
  margin: 1em 0 1em 0;
}
.timelinecard {
  margin: 0.5em 0 0.5em 0;
}
</style>

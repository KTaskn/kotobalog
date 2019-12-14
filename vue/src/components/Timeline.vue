<template>
  <div class="container">
    <h1 class="text-left">みんなの記録</h1>
    <TimelineCard
      class="timelinecard"
      v-for="a_sentence in l_sentence"
      v-bind:key="a_sentence.id"
      v-bind:sentence="a_sentence"
      ></TimelineCard>

    <b-pagination-nav
      :link-gen="linkGen"
      :v-model="currentpage"
      :number-of-pages="numpage"
      :hide-goto-end-buttons="true"
      @change="next"
      align="center"
    ></b-pagination-nav>
  </div>
</template>

<script>
import Global from '@/global/index'
import TimelineCard from '@/components/TimelineCard'
export default {
  mounted () {
    this.get_timeline({
      'page': 1
    })
  },
  data () {
    return {
      l_sentence: [
      ],
      currentpage: 1,
      numpage: 1,
      lastid: 0
    }
  },
  components: {
    TimelineCard
  },
  methods: {
    get_timeline (data = {}) {
      this.get_note('/timeline/get', data)
    },
    get_note (url, data = {}) {
      return Global.get_wrapper(
        url,
        data
      ).then((res) => {
        if (res.data.result) {
          this.l_sentence = res.data.sentences
          this.numpage = res.data.numpage
          this.lastid = res.data.lastid
        } else {
        }
      })
    },
    next (pagenum) {
      console.log('next', pagenum)
      this.get_timeline({
        'page': pagenum,
        'lastid': this.lastid
      })
    },
    linkGen (pagenum) {
      return '/#'
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

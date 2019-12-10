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
      base-url="#"
      :value="currentpage"
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
    this.get_timeline()
  },
  data () {
    return {
      l_sentence: [
      ],
      currentpage: 3,
      numpage: 5
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
      return Global.get_wrapper(
        url
      ).then((res) => {
        if (res.data.result) {
          this.l_sentence = res.data.sentences
        } else {
        }
      })
    },
    next () {
      console.log('next')
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

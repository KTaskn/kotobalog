<template>
  <div class="container" id="main-container">
    <h1 class="text-left">@{{ name }}さんの記録</h1>
    <p class="text-left" v-if=(!l_sentence.length)>保存された記録はありません。</p>
    <SentenceCard
      class="sentencecard"
      v-for="a_sentence in l_sentence"
      v-bind:key="a_sentence.id"
      v-bind:sentence="a_sentence"></SentenceCard>

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
import SentenceCard from '@/components/SentenceCard'
export default {
  components: {
    SentenceCard
  },
  mounted () {
    if (localStorage.access_token) {
    } else {
      this.$router.push({ path: '/signup' })
    }
    this.name = localStorage.name
    this.get_sentences()
  },
  data () {
    return {
      l_sentence: [
      ],
      name: '',
      currentpage: 1,
      numpage: 1,
      lastid: 0
    }
  },
  methods: {
    get_sentences (data = {}) {
      this.get_note('/sentence/getmine', data)
    },
    get_note (url, data) {
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
      this.get_sentences({
        'page': pagenum,
        'lastid': this.lastid
      })
    },
    linkGen (pagenum) {
      scrollTo(0, 0)
      return '#'
    }
  }
}
</script>

<style scoped>
#main-container {
  margin-top: 1em;
}
.sentencecard {
  margin: 1em 0 1em 0;
}
h1 {
  font-size:1.5rem
}
</style>

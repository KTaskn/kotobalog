<template>
  <div class="container ">
    <SentenceCard
      v-for="a_sentence in l_sentence"
      v-bind:key="a_sentence.id"
      v-bind:card="a_sentence"></SentenceCard>
      <b-button>&#8249;</b-button>
      <b-button>&#8250;</b-button>
  </div>
</template>

<script>
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
  },
  data () {
    return {
      l_sentence: [
        {id: 1, sentence: 'sentence_1', creator: 'creator_1'},
        {id: 2, sentence: 'sentence_2', creator: 'creator_2'},
        {id: 3, sentence: 'sentence_3', creator: 'creator_3'}
      ]
    }
  }
}
</script>

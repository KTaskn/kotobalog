<template>
  <div class="container" id="main-container">
    <SentenceCard
      v-for="a_sentence in l_sentence"
      v-bind:key="a_sentence.id"
      v-bind:sentence="a_sentence"></SentenceCard>
      <b-button v-on:click=pagedown v-if=show_pagedown>&#8249;</b-button>
      <b-button v-on:click=pageup v-if=show_pageup>&#8250;</b-button>
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

    this.get_sentences()
  },
  data () {
    return {
      l_sentence: [
      ],
      page: 0,
      is_over: true,
      show_pagedown: false,
      show_pageup: false
    }
  },
  methods: {
    get_sentences () {
      this.post_note('/sentence/getmine', {
        offset: this.page
      })
    },
    post_note (url, data) {
      return Global.post_wrapper(
        url,
        {
          offset: data.offset
        }
      ).then((res) => {
        if (res.data.result) {
          console.log(res.data)
          this.l_sentence = res.data.sentences
          this.is_over = res.data.is_over
          this.check_pagebutton()
        } else {
        }
      })
    },
    pageup () {
      if (!this.is_over) {
        this.page += 1
        this.get_sentences()
      }
    },
    pagedown () {
      if (this.page > 0) {
        this.page -= 1
        this.get_sentences()
      }
    },
    check_pagebutton () {
      if (this.page === 0) {
        this.show_pagedown = false
      } else {
        this.show_pagedown = true
      }

      if (this.is_over === true) {
        this.show_pageup = false
      } else {
        this.show_pageup = true
      }
    }
  }
}
</script>

<style scoped>
#main-container {
  margin-top: 1em
}
</style>

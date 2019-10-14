<template>
  <b-card class="timeline-card" :title="card.sentence" :sub-title="card.creator">
    <b-card-text v-if=show_text>{{ card.publisher }} {{ card.title }}</b-card-text>
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
  }
}
</script>

<style scoped>
</style>

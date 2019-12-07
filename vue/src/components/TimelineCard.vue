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
      <v-icon name="heart" color="#f00" scale="1" v-if="card.likeit"/>
      <v-icon name="regular/heart" scale="1" v-if="!card.likeit"/>
      <span id="likeit">
        {{ card.likenum }}
      </span>
    </b-card-footer>
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
        title: this.sentence.title,
        likenum: this.sentence.likenum
      },
      show_text: false
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

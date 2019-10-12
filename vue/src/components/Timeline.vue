<template>
  <div class="component">
    <TimelineCard v-for="(index, a_card) in cards" :key="index">{{ a_card }}</TimelineCard>
  </div>
</template>

<script>
import TimelineCard from '@/components/TimelineCard'
export default {
  data () {
    return {
      cards: ['message_1', 'message_2', 'message_3']
    }
  },
  components: {
    TimelineCard
  }
}
</script>

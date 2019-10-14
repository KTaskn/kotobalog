<template>
  <b-card :title="card.sentence" :sub-title="card.creator">
  </b-card>
</template>

<script>
export default {
  props: ['card']
}
</script>

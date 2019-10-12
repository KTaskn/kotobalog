<template>
  <b-card :title="card.sentence" :sub-title="card.creator">
    <a href="#" class="card-link">Card link</a>
    <b-link href="#" class="card-link">Another link</b-link>
  </b-card>
</template>

<script>
export default {
  props: ['card']
}
</script>

<template>
  <div>
    <TopHeader class="h-50"></TopHeader>
    <b-container offset="1">
      <Timeline></Timeline>
    </b-container>
  </div>
</template>

<script>
import TopHeader from '@/components/TopHeader'
import Timeline from '@/components/Timeline'
export default {
  components: {
    Timeline,
    TopHeader
  }
}
</script>

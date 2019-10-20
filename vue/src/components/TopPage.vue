<template>
  <div>
    <TopHeader class="h-50"></TopHeader>
    <Timeline></Timeline>
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

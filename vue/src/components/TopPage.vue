<template>
  <div>
    <div class="h-60">
      <TopHeader></TopHeader>
    </div>
    <div>
      <Timeline></Timeline>
    </div>
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

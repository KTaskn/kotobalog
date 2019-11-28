<template>
  <div>
    <TopHeader class="h-50"></TopHeader>
    <Timeline></Timeline>
  </div>
</template>

<script>
const TopHeader = () => import('@/components/TopHeader')
const Timeline = () => import('@/components/Timeline')
export default {
  components: {
    Timeline,
    TopHeader
  }
}
</script>

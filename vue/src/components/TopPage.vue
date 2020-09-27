<template>
  <div>
    <TopHeader class="h-50"></TopHeader>
    <NoteComponent @reloadtimeline="reload"></NoteComponent>
    <b-container offset="1">
      <Timeline ref="timeline"></Timeline>
    </b-container>
  </div>
</template>

<script>
import NoteComponent from '@/components/NoteComponent'
import TopHeader from '@/components/TopHeader'
import Timeline from '@/components/Timeline'
export default {
  components: {
    NoteComponent,
    Timeline,
    TopHeader
  },
  methods: {
    reload () {
      console.log('reloadtimeline')
      this.$refs.timeline.get_timeline()
    }
  }
}
</script>

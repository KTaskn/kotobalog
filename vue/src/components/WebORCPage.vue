<template>
  <div id="app">
    <div>
      <video ref="video" id="video" width="0" height="0" autoplay muted playsinline style=""></video>
      <canvas ref="canvas" id="canvas" width="250" height="250"
        v-on:touchstart="startDraw"
        v-on:touchmove="Draw"
        v-on:touchend="endDraw"
      ></canvas>
      <canvas ref="canvas" id="canvas2" width="250" height="250"
      ></canvas>
    </div>
  </div>
</template>

<script>
const T = 3000
const $body = document.querySelector('body')
let scrollPosition = 0
export default {
  data () {
    return {
      video: {},
      canvas: {},
      captures: [],
      mouseDown: false,
      wbound: 0,
      start: {
        x: null,
        y: null
      },
      end: {
        x: null,
        y: null
      },
      context: null,
      droptime: null

    }
  },
  mounted () {
    scrollPosition = window.pageYOffset
    $body.style.overflow = 'hidden'
    $body.style.position = 'fixed'
    $body.style.top = `-${scrollPosition}px`
    $body.style.width = '100%'
    this.video = this.$refs.video
    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
      navigator.mediaDevices.getUserMedia({
        // video: true
        video: {
          facingMode: { ideal: 'environment' }
        }
      }).then(stream => {
        this.video.srcObject = stream
        this.video.play()
      })

      this.video.addEventListener('timeupdate', () => {
        var canvas = document.getElementById('canvas')
        canvas.getContext('2d').drawImage(this.video, 0, 0, 250, 250)
      }, true)
    }
  },
  methods: {
    capture () {
      this.canvas = this.$refs.canvas
      this.canvas.getContext('2d').drawImage(this.video, 0, 0, 250, 250)
      this.captures.push(this.canvas.toDataURL('image/png'))
      console.log(this.captures)
    },
    startDraw (event) {
      // マウスボタンが押された
      this.mouseDown = true
      // canvasの絶対座標を取得
      this.wbound = event.target.getBoundingClientRect()
      // マウスの座標（始点）をセット
      this.start = {
        x: event.touches[0].clientX - this.wbound.left,
        y: event.touches[0].clientY - this.wbound.top
      }
    },
    Draw (event) {
      // マウスボタンが押されていれば描画
      if (this.mouseDown) {
        // マウスの座標(終点）を取得
        this.end = {
          x: event.touches[0].clientX - this.wbound.left,
          y: event.touches[0].clientY - this.wbound.top
        }
      }
    },
    endDraw (event) {
      // マウスボタンが押されていれば描画
      if (this.mouseDown) {
        if (this.context === null) {
          var canvas2 = document.getElementById('canvas2')
          // コンテキストの取得
          this.context = canvas2.getContext('2d')
          this.context.beginPath()
        } else {
          console.log('there is context')
        }

        // パスの開始
        this.context.moveTo(this.start.x - 10, this.start.y)
        this.context.lineTo(this.start.x + 10, this.start.y)
        this.context.lineTo(this.end.x + 10, this.end.y)
        this.context.lineTo(this.end.x - 10, this.end.y)
        this.context.lineTo(this.start.x - 10, this.start.y)
        this.droptime = new Date()
        setTimeout(() => {
          this.Clip(this.context)
        }, T)
        // マウスボタンが離された
        this.mouseDown = false
      }
    },
    Clip (context) {
      context.clip()
      console.log('Clip')
      var now = new Date()
      console.log(now - this.droptime)
      if (now - this.droptime > T - 100) {
        context.drawImage(this.video, 0, 0, 400, 400, 0, 0, 200, 200)
      }
    }
  }
}
</script>

<style scoped>
</style>

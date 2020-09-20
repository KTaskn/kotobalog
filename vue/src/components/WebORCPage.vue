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
      <ul>
      <li class="capture" v-for="c in captures" v-bind:key="c.d">
        <img v-bind:src="c" height="50" />
      </li>
      <p>{{ log }}</p>
      </ul>
    </div>
  </div>
</template>

<script>
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
      startX: 0,
      startY: 0,
      endX: 0,
      endY: 0,
      context: null,
      log: ''
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
      console.log('startDraw')
      this.log += 'startDraw:' + this.startX + ',' + this.startY
      // マウスボタンが押された
      this.mouseDown = true
      // canvasの絶対座標を取得
      this.wbound = event.target.getBoundingClientRect()
      // マウスの座標（始点）をセット
      // this.startX = event.clientX - this.wbound.left
      // this.startY = event.clientY - this.wbound.top
      this.startX = event.touches[0].clientX - this.wbound.left
      this.startY = event.touches[0].clientY - this.wbound.top
    },
    Draw (event) {
      console.log('Draw')
      // this.log += 'Draw'
      // マウスボタンが押されていれば描画
      if (this.mouseDown) {
        // キャンバスの取得
        this.canvas = document.getElementById('canvas')
        // コンテキストの取得
        this.context = this.canvas.getContext('2d')
        // マウスの座標(終点）を取得
        this.endX = event.touches[0].clientX - this.wbound.left
        this.endY = event.touches[0].clientY - this.wbound.top
      }
    },
    endDraw (event) {
      console.log('endDraw')
      this.log += 'endDraw:' + this.endX + ',' + this.endY
      // マウスボタンが押されていれば描画
      if (this.mouseDown) {
        var canvas2 = document.getElementById('canvas2')
        // コンテキストの取得
        var tmpContext = canvas2.getContext('2d')

        // パスの開始
        // マウスボタンが離された
        this.mouseDown = false

        tmpContext.beginPath()
        // // 線の色セット
        tmpContext.strokestartYle = 'black'
        // // 線の太さセット
        tmpContext.lineWidth = 15
        // // 線端の形状セット
        tmpContext.lineCap = 'round'
        tmpContext.moveTo(this.startX - 10, this.startY)
        tmpContext.lineTo(this.startX + 10, this.startY)
        tmpContext.lineTo(this.endX + 10, this.endY)
        tmpContext.lineTo(this.endX - 10, this.endY)
        tmpContext.lineTo(this.startX - 10, this.startY)
        tmpContext.clip()

        tmpContext.drawImage(this.video, 0, 0, 400, 400, 0, 0, 200, 200)
      }
    }
  }
}
</script>

<style scoped>
</style>

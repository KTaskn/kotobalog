<template>
  <div class="container">
    <b-form>
      <b-alert variant="danger" :show=haserror>保存に失敗しました</b-alert>
      <b-alert variant="warning" :show="form.sentence.length > 200">申し訳ありません。コトバは２００文字以内です。</b-alert>

      <b-form-group id="input-group-1" class="text-left" label="コトバ:" label-for="input-1">
        <b-form-textarea
          id="input-1"
          v-model="form.sentence"
          type="text"
          required
          placeholder=""
          rows="3"
          max-rows="3"
        ></b-form-textarea>
      </b-form-group>

      <b-tooltip class="input-tooltip" target="input-group-1" placement="bottom">
        例えばこんなコトバを記録しましょう<br/>
        国境の長いトンネルを抜けると雪国であった。 / クリリンのことかー!!!!
      </b-tooltip>

      <div class="clearfix">
        <b-button @click="switch_collpase" class="float-left" size="sm">詳細を追加</b-button>
      </div>

      <div>
        <b-collapse v-model="collapse_show" id="collapse">
          <b-form-group id="input-group-2" class="text-left" label="作者:" label-for="input-2">
            <b-form-input
              id="input-2"
              v-model="form.creator"
              type="text"
              required
              placeholder=""
              v-b-tooltip.hover
              title="コトバの作者、発言者を記載しましょう"
            ></b-form-input>
          </b-form-group>

          <div class="clearfix">
            <b-button variant="danger"
            @click="creator_is_unknown"
            class="float-right" size="sm">作者は不明です</b-button>
          </div>

          <b-form-group id="input-group-6" class="text-left" label="コメント:" label-for="input-6">
            <b-form-textarea
              id="input-6"
              v-model="form.comment"
              type="text"
              required
              placeholder=""
              v-b-tooltip.hover
              title="コトバへの感想・コメントを記載しましょう"
              rows="3"
              max-rows="3"
            ></b-form-textarea>
          </b-form-group>

          <div class="clearfix">
            <b-button variant="danger"
            @click="abbreviate_comment"
            class="float-right" size="sm">コメントを省略する</b-button>
          </div>

          <b-form-group id="input-group-3" class="text-left" label="ISBNコード:" label-for="input-3">
            <b-form-input
              id="input-3"
              v-model="form.isbn"
              type="text"
              placeholder=""
            ></b-form-input>
          </b-form-group>

          <b-form-group id="input-group-4" class="text-left" label="タイトル：" label-for="input-4">
            <b-form-input
              id="input-4"
              v-model="form.title"
              type="text"
              placeholder=""
            ></b-form-input>
          </b-form-group>

          <b-form-group id="input-group-5" class="text-left" label="出版社：" label-for="input-5">
            <b-form-input
              id="input-5"
              v-model="form.publisher"
              type="text"
              placeholder=""
            ></b-form-input>
          </b-form-group>
        </b-collapse>
      </div>

      <b-button @click="onSubmit" type="button">登録</b-button>
    </b-form>
  </div>
</template>

<script>
import Global from '@/global/index'
export default {
  components: {
  },
  mounted () {
  },
  data () {
    return {
      form: {
        sentence: '',
        creator: '',
        isbn: '',
        title: '',
        publisher: '',
        comment: ''
      },
      haserror: false,
      collapse_show: false
    }
  },
  methods: {
    switch_collpase () {
      this.collapse_show = !(this.collapse_show)
    },
    close_collpase () {
      this.collapse_show = false
    },
    creator_is_unknown (event) {
      this.form.creator = '作者不明'
    },
    abbreviate_comment (event) {
      this.form.comment = 'コメントは省略しました'
    },
    onSubmit (evt) {
      if (this.form.creator === '') {
        this.form.creator = '作者不明'
      }
      if (this.form.comment === '') {
        this.form.creator = 'コメントは省略しました'
      }
      this.post_note('/timeline/anonymousnote', this.form)
    },
    post_note (url, data) {
      return Global.post_wrapper(
        url,
        {
          title: data.title,
          creator: data.creator,
          publisher: data.publisher,
          isbn: data.isbn,
          sentence: data.sentence,
          comment: data.comment
        }
      ).then((res) => {
        if (res.data.result) {
          this.haserror = false
          console.log('success')
          this.form = {
            sentence: '',
            creator: '',
            isbn: '',
            title: '',
            publisher: '',
            comment: ''
          }
          this.$emit('reloadtimeline')
          this.close_collpase()
        } else {
          console.log('failed')
          this.haserror = true
        }
      })
    }
  }
}
</script>

<style scoped>
.tooltip {
  font-size: 8pt;
}
</style>

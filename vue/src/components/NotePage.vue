<template>
  <div class="container">
    <b-form @submit="onSubmit">

      <b-form-group id="input-group-1" class="text-left" label="言葉:" label-for="input-1">
        <b-form-input
          id="input-1"
          v-model="form.sentence"
          type="text"
          required
          placeholder="文章"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-2" class="text-left" label="ISBNコード:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.isbn"
          type="text"
          placeholder="ISBNコード"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-3" class="text-left" label="作者:" label-for="input-3">
        <b-form-input
          id="input-3"
          v-model="form.creator"
          type="text"
          required
          placeholder="作者"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-4" class="text-left" label="タイトル：" label-for="input-4">
        <b-form-input
          id="input-4"
          v-model="form.title"
          type="text"
          placeholder="書籍名"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-5" class="text-left" label="出版社：" label-for="input-5">
        <b-form-input
          id="input-5"
          v-model="form.title"
          type="text"
          placeholder="出版社"
        ></b-form-input>
      </b-form-group>

      <b-button type="submit" variant="primary">登録</b-button>
    </b-form>
  </div>
</template>

<script>
export default {
  components: {
  },
  mounted () {
    if (localStorage.access_token) {
    } else {
      this.$router.push({ path: '/signup' })
    }
  },
  data () {
    return {
      form: {
        sentence: '',
        creator: '',
        isbn: '',
        title: '',
        publisher: ''
      }
    }
  },
  methods: {
    onSubmit (evt) {
      return ''
    }
  }
}
</script>

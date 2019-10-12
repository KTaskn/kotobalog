<template>
  <div class="container">
    <b-form @submit="onSubmit">

      <b-form-group id="input-group-1" class="text-left" label="Name:" label-for="input-1">
        <b-form-input
          id="input-1"
          v-model="form.name"
          type="text"
          required
          placeholder="name"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-2" class="text-left" label="パスワード:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.password"
          type="password"
          required
          placeholder="passowrd"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-3" class="text-left" label="パスワード（確認用）:" label-for="input-3">
        <b-form-input
          id="input-3"
          v-model="form.password_check"
          type="password"
          required
          placeholder="passowrd-check"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-4" class="text-left" label="Email:" label-for="input-4">
        <b-form-input
          id="input-4"
          v-model="form.email"
          type="email"
          required
          placeholder="Enter email"
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
  data () {
    return {
      form: {
        email: '',
        name: '',
        password: '',
        password_check: ''
      }
    }
  },
  methods: {
    onSubmit (evt) {
      return ''
    },
    onReset (evt) {
      return ''
    }
  }
}
</script>

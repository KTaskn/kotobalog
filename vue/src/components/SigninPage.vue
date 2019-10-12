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

      <b-button type="submit" variant="primary">ログイン</b-button>
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
        name: '',
        password: ''
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

<template>
  <div class="container">
    <b-form @submit="onSubmit">
      <span v-show=haserror>ログインできませんでした</span>
      <b-form-group id="input-group-1" class="text-left" label="ユーザ名 または メールアドレス:" label-for="input-1">
        <b-form-input
          id="input-1"
          v-model="form.name_or_email"
          type="text"
          required
          placeholder=""
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-2" class="text-left" label="パスワード:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.password"
          type="password"
          required
          placeholder=""
        ></b-form-input>
      </b-form-group>

      <b-button type="submit">ログイン</b-button>
    </b-form>
  </div>
</template>

<script>
import Global from '@/global/index'

export default {
  components: {
  },
  data () {
    return {
      form: {
        name_or_email: '',
        password: ''
      },
      haserror: false
    }
  },
  methods: {
    onSubmit (evt) {
      this.post_signin('/user/signin', this.form)
      return ''
    },
    post_signin (url, data) {
      return Global.post_wrapper(
        url,
        {
          name_or_email: data.name_or_email,
          password: data.password
        }
      ).then((res) => {
        if (res.data.result) {
          localStorage.name = res.data.name
          localStorage.access_token = res.data.access_token
          localStorage.access_token_expiration = res.data.access_token_expiration
          localStorage.refresh_token = res.data.refresh_token
          localStorage.refresh_token_expiration = res.data.refresh_token_expiration
          this.$router.push({ path: '/note' })
          this.$eventHub.$emit('raise_show_signout')
        } else {
          localStorage.removeItem('name')
          localStorage.removeItem('access_token')
          localStorage.removeItem('refresh_token')
          localStorage.removeItem('access_token_expiration')
          localStorage.removeItem('refresh_token_expiration')
          this.$eventHub.$emit('drop_show_signout')
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

<template>
  <div class="container">
    <b-form @submit="onSubmit">
      <span>利用には登録が必要です。</span>
      <span>アカウントをもっている場合は<router-link to="/signin">ログイン</router-link>してください</span>
      <span v-show=haserror>作成できませんでした</span>
      <b-form-group id="input-group-1" class="text-left signupinput" label="ユーザ名:" label-for="input-1">
        <b-form-input
          id="input-1"
          v-model="form.name"
          type="text"
          required
          placeholder=""
          v-b-tooltip.hover title="半角英数字15文字以下で希望のユーザ名を記入してください"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-2" class="text-left" label="パスワード:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.password"
          type="password"
          required
          placeholder=""
          v-b-tooltip.hover title="半角英数字で任意のパスワードを記入してください"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-3" class="text-left" label="パスワード（確認用）:" label-for="input-3">
        <b-form-input
          id="input-3"
          v-model="form.password_check"
          type="password"
          required
          placeholder=""
          v-b-tooltip.hover title="半角英数字で任意のパスワードを記入してください"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-4" class="text-left" label="メールアドレス:" label-for="input-4">
        <b-form-input
          id="input-4"
          v-model="form.email"
          type="email"
          required
          placeholder=""
        ></b-form-input>
      </b-form-group>

      <b-button type="submit" variant="primary">登録</b-button>
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
        email: '',
        name: '',
        password: '',
        password_check: ''
      },
      haserror: false
    }
  },
  methods: {
    onSubmit (evt) {
      this.post_signup('/user/signup', this.form)
      return ''
    },
    post_signup (url, data) {
      return Global.post_wrapper(
        url,
        {
          email: data.email,
          name: data.name,
          password: data.password,
          password_check: data.password_check
        }
      ).then((res) => {
        if (res.data.result) {
          localStorage.name = res.data.name
          localStorage.access_token = res.data.access_token
          localStorage.access_token_expiration = res.data.access_token_expiration
          localStorage.refresh_token = res.data.refresh_token
          localStorage.refresh_token_expiration = res.data.refresh_token_expiration
          this.$eventHub.$emit('raise_show_signout')
          this.$router.push({ path: '/note' })
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

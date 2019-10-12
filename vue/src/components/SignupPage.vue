<template>
  <div class="container">
    <b-form @submit="onSubmit">

      <span>アカウントをもっている場合は<router-link to="/signin">ログイン</router-link></span>

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
import axios from 'axios'
import Global from '@/global/index'

export default {
  components: {
  },
  data () {
    return {
      form: {
        email: 'example@example.com',
        name: 'name',
        password: 'test_password',
        password_check: 'test_password'
      }
    }
  },
  methods: {
    onSubmit (evt) {
      this.post_signup('/user/signup', this.form)
      return ''
    },
    post_signup (url, data) {
      return axios.post(
        Global.API_URL + url,
        {
          email: data.email,
          name: data.name,
          password: data.password,
          password_check: data.password_check
        },
        {
          headers: {
            'Content-Type': 'application/json'
          }
        }
      ).then((res) => {
        if (res.data.result) {
          localStorage.name = res.data.name
          localStorage.access_token = res.data.access_token
          localStorage.refresh_token = res.data.refresh_token
          this.$router.push({ path: '/note' })
          this.$eventHub.$emit('raise_show_signout')
        } else {
          localStorage.removeItem('name')
          localStorage.removeItem('access_token')
          localStorage.removeItem('refresh_token')
          this.$eventHub.$emit('drop_show_signout')
        }
      })
    }
  }
}
</script>

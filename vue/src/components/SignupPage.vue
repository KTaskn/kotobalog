<template>
  <b-container>
    <b-row class="justify-content-md-center">
      <b-col>
        <span>利用には登録が必要です。</span>
        <span>アカウントをもっている場合は<router-link to="/signin">サインイン</router-link>してください</span>
        <b-alert variant="danger" :show="haserror">作成できませんでした</b-alert>
        <b-alert variant="danger" :show="form.name.length > 16 || is_alphanum_name">ユーザ名は半角英数字15文字以下の必要があります</b-alert>
        <b-alert variant="warning" :show="is_duplicated_name">申し訳ございません。そのユーザ名はすでに他の方に利用されています。</b-alert>
        <b-alert variant="warning" :show="is_duplicated_email">メールアドレスはすでに登録済みです。</b-alert>
        <b-alert variant="danger" :show="form.password !== form.password_check">パスワードとパスワード（確認用）が一致しません</b-alert>
      </b-col>
    </b-row>

    <b-row id="oauth-login">
      <b-col>
        <b-button id="twitter-oauth-button" @click="callTwitterOAuth">
          <font-awesome-icon :icon="['fab', 'twitter']" size="1x"/>
          Twitterアカウントを利用して登録
        </b-button>
      </b-col>
    </b-row>

    <b-row>
      <b-col>
        <span>またはユーザー情報を入力して登録</span>
      </b-col>
    </b-row>

    <b-row class="text-center">
      <b-col>
        <b-form>

          <b-form-group id="input-group-1" class="text-left signupinput" label="ユーザ名:" label-for="input-1">
            <b-form-input
              id="input-1"
              v-model="form.name"
              type="text"
              required
              placeholder=""
              @change="checkname"
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
              @change="checkemail"
            ></b-form-input>
          </b-form-group>

          <b-button @click="onSubmit" type="button">登録</b-button>
        </b-form>
      </b-col>
    </b-row>
  </b-container>
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
      haserror: false,
      is_duplicated_name: false,
      is_alphanum_name: false,
      is_duplicated_email: false
    }
  },
  methods: {
    callTwitterOAuth () {
      this.get_twitterOAuth('/user/twitteroauth')
    },
    get_twitterOAuth (url) {
      return Global.get_wrapper(
        url
      ).then((res) => {
        if (res.data.result) {
          window.location = res.data.oauth_url
        } else {
          this.$eventHub.$emit('drop_show_signout')
          this.haserror = true
        }
      })
    },
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
    },
    checkname_is_alphanum (name) {
      if (name.match(/^[A-Za-z0-9_]*$/)) {
        this.is_alphanum_name = false
      } else {
        this.is_alphanum_name = true
      }
    },
    checkname () {
      this.get_namecheck('/user/namecheck', this.form.name)
      this.checkname_is_alphanum(this.form.name)
    },
    get_namecheck (url, name) {
      return Global.get_wrapper(
        url,
        {
          name: name
        }
      ).then((res) => {
        this.is_duplicated_name = res.data.is_duplicated
      })
    },
    checkemail () {
      console.log('checkemail')
      this.get_emailcheck('/user/emailcheck', this.form.email)
    },
    get_emailcheck (url, email) {
      return Global.get_wrapper(
        url,
        {
          email: email
        }
      ).then((res) => {
        this.is_duplicated_email = res.data.is_duplicated
      })
    }
  }
}
</script>

<style scoped>
.tooltip {
  font-size: 8pt;
}
#oauth-login {
  margin-top: 3em;
  margin-bottom: 3em;
}
</style>

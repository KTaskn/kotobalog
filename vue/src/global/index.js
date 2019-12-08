
import axios from 'axios'
const APP_NAME = 'コトバノート'
const API_URL = process.env.API_URL

export default {
  APP_NAME: APP_NAME,
  API_URL: API_URL,
  initializing_authorization_and_redirect_top: function () {
    console.log('ログイン情報が存在しませんでした。トップページに遷移します。')
    localStorage.removeItem('name')
    localStorage.removeItem('access_token')
    localStorage.removeItem('refresh_token')
    localStorage.removeItem('access_token_expiration')
    localStorage.removeItem('refresh_token_expiration')
    window.location = '/'
  },
  refresh_token: function () {
    // トークンの期限判定
    let now = new Date()
    now.setHours(now.getHours() - 4)
    let expiration = new Date(localStorage.access_token_expiration)
    if (now > expiration) {
      // トークンが切れそうな場合は更新する
      axios.post(
        API_URL + '/user/refresh',
        {
          name: localStorage.name
        },
        {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Token ' + localStorage.refresh_token
          }
        }
      ).then((res) => {
        if (res.data.result) {
          localStorage.name = res.data.name
          localStorage.access_token = res.data.access_token
          localStorage.access_token_expiration = res.data.access_token_expiration
          localStorage.refresh_token = res.data.refresh_token
          localStorage.refresh_token_expiration = res.data.refresh_token_expiration
        } else {
          // 認証エラーの場合はlocalStorageの認証情報を削除してトップページにリダイレクトする
          this.initializing_authorization_and_redirect_top()
        }
      })
    }
  },
  post_wrapper: function (url, params = {}, headers = {'Content-Type': 'application/json'}) {
    if (localStorage.access_token) {
      this.refresh_token()
      params['name'] = localStorage.name
      if (!headers['Authorization']) {
        headers['Authorization'] = 'Token ' + localStorage.access_token
      }
    }
    return axios.post(
      API_URL + url,
      params,
      {
        headers: headers
      }
    ).catch(err => {
      console.log('you got error:', err)
      if (err.response.status === 401) {
        // 認証エラーの場合はlocalStorageの認証情報を削除してトップページにリダイレクトする
        this.initializing_authorization_and_redirect_top()
      }
    })
  },
  get_wrapper: function (url, params = {}, headers = {'Content-Type': 'application/json'}) {
    if (localStorage.access_token) {
      this.refresh_token()
      params['name'] = localStorage.name
      if (!headers['Authorization']) {
        headers['Authorization'] = 'Token ' + localStorage.access_token
      }
    }
    return axios.get(
      API_URL + url,
      {
        params: params,
        headers: headers
      }
    ).catch(err => {
      console.log('you got error:', err)
      if (err.response.status === 401) {
        // 認証エラーの場合はlocalStorageの認証情報を削除してトップページにリダイレクトする
        this.initializing_authorization_and_redirect_top()
      }
    })
  }
}

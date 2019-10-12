
import axios from 'axios'
const APP_NAME = 'Kotobalog'
const API_URL = 'http://localhost:8900/api'

export default {
  APP_NAME: APP_NAME,
  API_URL: API_URL,
  post_wrapper: function (url, params) {
    let now = new Date()
    let expiration = new Date(localStorage.access_token_expiration)

    if (now > expiration) {
      console.log('refresh token')
    }

    params['access_token'] = localStorage.access_token
    return axios.post(
      API_URL + url,
      params,
      {
        headers: {
          'Content-Type': 'application/json'
        }
      }
    )
  }
}

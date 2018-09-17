import axios from 'axios'
import httpAdapter from 'axios/lib/adapters/http'
import { camelizeKeys, decamelizeKeys } from 'humps'

const TYPE_JSON = 'application/json'
const TYPE_MULTIPART = 'multipart/form-data'

const json = axios.create({
  adapter: httpAdapter,
  baseURL: '/',
  headers: {
    'Content-Type': TYPE_JSON,
    Accept: TYPE_JSON
  },
  transformResponse: [
    ...axios.defaults.transformResponse,
    data => camelizeKeys(data)
  ],
  transformRequest: [
    data => decamelizeKeys(data),
    ...axios.defaults.transformRequest
  ]
})

const multipart = axios.create({
  adapter: httpAdapter,
  baseURL: '/',
  headers: {
    'Content-Type': TYPE_MULTIPART,
    Accept: TYPE_JSON
  },
  transformResponse: [
    ...axios.defaults.transformResponse,
    data => camelizeKeys(data)
  ]
})

export { json, multipart }

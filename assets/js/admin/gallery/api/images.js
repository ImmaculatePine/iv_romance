import { json, multipart } from './http'

export default token => {
  json.defaults.headers.common['Authorization'] = `Bearer ${token}`
  multipart.defaults.headers.common['Authorization'] = `Bearer ${token}`

  return {
    fetch: galleryId => json.get(`/api/admin/galleries/${galleryId}/images`),
    create: (galleryId, { position, file }) => {
      const formData = new FormData()
      formData.append('image[position]', position)
      formData.append('image[file]', file)
      return multipart.post(
        `/api/admin/galleries/${galleryId}/images`,
        formData
      )
    },
    delete: (galleryId, id) =>
      json.delete(`/api/admin/galleries/${galleryId}/images/${id}`)
  }
}

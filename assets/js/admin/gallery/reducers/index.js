import {
  FETCH_IMAGES_SUCCESS,
  CREATE_IMAGE_SUCCESS,
  DELETE_IMAGE_SUCCESS
} from '../constants/images'

export const initialState = {
  galleryId: null,
  token: null,
  images: []
}

export default (state = initialState, { type, payload } = {}) => {
  switch (type) {
    case FETCH_IMAGES_SUCCESS:
      return Object.assign({}, state, {
        isLoading: false,
        images: payload
      })

    case CREATE_IMAGE_SUCCESS:
      return Object.assign({}, state, {
        images: [...state.images, payload]
      })

    case DELETE_IMAGE_SUCCESS:
      return Object.assign({}, state, {
        images: state.images.filter(({ id }) => id !== payload)
      })

    default:
      return state
  }
}

import {
  FETCH_IMAGES_REQUEST,
  FETCH_IMAGES_SUCCESS,
  FETCH_IMAGES_FAILURE,
  CREATE_IMAGE_REQUEST,
  CREATE_IMAGE_SUCCESS,
  CREATE_IMAGE_FAILURE,
  DELETE_IMAGE_SUCCESS
} from '../constants/images'

export const initialState = {
  galleryId: null,
  token: null,
  isLoading: false,
  images: []
}

export default (state = initialState, { type, payload } = {}) => {
  switch (type) {
    case FETCH_IMAGES_REQUEST:
      return {
        ...state,
        isLoading: true
      }

    case FETCH_IMAGES_SUCCESS:
      return {
        ...state,
        isLoading: false,
        images: payload
      }

    case FETCH_IMAGES_FAILURE:
      return {
        ...state,
        isLoading: false
      }

    case CREATE_IMAGE_REQUEST:
      return {
        ...state,
        isLoading: true
      }

    case CREATE_IMAGE_SUCCESS:
      return {
        ...state,
        isLoading: false,
        images: [...state.images, payload]
      }

    case CREATE_IMAGE_FAILURE:
      return {
        ...state,
        isLoading: false
      }

    case DELETE_IMAGE_SUCCESS:
      return {
        ...state,
        images: state.images.filter(({ id }) => id !== payload)
      }

    default:
      return state
  }
}

import {
  FETCH_IMAGES_REQUEST,
  FETCH_IMAGES_SUCCESS,
  FETCH_IMAGES_FAILURE,
  CREATE_IMAGE_REQUEST,
  CREATE_IMAGE_SUCCESS,
  CREATE_IMAGE_FAILURE,
  DELETE_IMAGE_REQUEST,
  DELETE_IMAGE_SUCCESS,
  DELETE_IMAGE_FAILURE
} from '../constants/images'
import buildImagesAPI from '../api/images'

const fetchImagesRequest = () => ({
  type: FETCH_IMAGES_REQUEST
})

const fetchImagesSuccess = payload => {
  return {
    type: FETCH_IMAGES_SUCCESS,
    payload
  }
}

const fetchImagesFailure = error => ({
  type: FETCH_IMAGES_FAILURE,
  payload: error
})

export const fetchImages = () => {
  return (dispatch, getState) => {
    const { galleryId, token } = getState()

    dispatch(fetchImagesRequest())

    return buildImagesAPI(token)
      .fetch(galleryId)
      .then(({ data }) => dispatch(fetchImagesSuccess(data)))
      .catch(error => dispatch(fetchImagesFailure(error)))
  }
}

const createImageRequest = () => ({
  type: CREATE_IMAGE_REQUEST
})

const createImageSuccess = payload => {
  return {
    type: CREATE_IMAGE_SUCCESS,
    payload
  }
}

const createImageFailure = error => ({
  type: CREATE_IMAGE_FAILURE,
  payload: error
})

export const createImage = image => {
  return (dispatch, getState) => {
    const { galleryId, token } = getState()

    dispatch(createImageRequest())

    return buildImagesAPI(token)
      .create(galleryId, image)
      .then(({ data }) => dispatch(createImageSuccess(data)))
      .catch(error => dispatch(createImageFailure(error)))
  }
}

const deleteImageRequest = () => ({
  type: DELETE_IMAGE_REQUEST
})

const deleteImageSuccess = payload => {
  return {
    type: DELETE_IMAGE_SUCCESS,
    payload
  }
}

const deleteImageFailure = error => ({
  type: DELETE_IMAGE_FAILURE,
  payload: error
})

export const deleteImage = id => {
  return (dispatch, getState) => {
    const { galleryId, token } = getState()

    dispatch(deleteImageRequest())

    return buildImagesAPI(token)
      .delete(galleryId, id)
      .then(() => dispatch(deleteImageSuccess(id)))
      .catch(error => dispatch(deleteImageFailure(error)))
  }
}

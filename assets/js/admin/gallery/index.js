import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { initialState } from './reducers'
import configureStore from './store'
import Gallery from './containers/gallery'

const initGallery = targetContainer => {
  const galleryId = targetContainer.getAttribute('data-gallery-id')
  const token = targetContainer.getAttribute('data-token')
  const store = configureStore(
    Object.assign({}, initialState, { galleryId, token })
  )

  return render(
    <Provider store={store}>
      <Gallery />
    </Provider>,
    targetContainer
  )
}

export default initGallery

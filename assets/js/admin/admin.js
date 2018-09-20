import 'phoenix_html'
import initGallery from './gallery'

const galleryRoot = document.getElementById('gallery-root')

if (galleryRoot) {
  initGallery(galleryRoot)
}

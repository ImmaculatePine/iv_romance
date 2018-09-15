import Masonry from 'masonry-layout'
import imagesLoaded from 'imagesloaded'
import SimpleLightbox from 'simple-lightbox'

const grid = document.querySelector('.grid')

if (grid) {
  imagesLoaded(grid, () => {
    new Masonry(grid, {
      itemSelector: '.grid-item',
      columnWidth: 250,
      gutter: 10
    })

    new SimpleLightbox({ elements: '.grid a' })
  })
}

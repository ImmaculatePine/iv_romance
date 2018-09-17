import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import Masonry from 'react-masonry-component'
import { getImages } from '../selectors/images'
import Image from './image'

const masonryOptions = {
  itemSelector: '.gallery-image',
  columnWidth: 250,
  gutter: 10
}
const imagesLoadedOptions = {}

export class List extends Component {
  static propTypes = {
    images: PropTypes.arrayOf(PropTypes.object).isRequired
  }

  render() {
    const { images } = this.props

    return (
      <Masonry
        updateOnEachImageLoad={true}
        options={masonryOptions}
        imagesLoadedOptions={imagesLoadedOptions}
      >
        {images.map(image => (
          <Image key={image.id} id={image.id} src={image.thumbUrl} />
        ))}
      </Masonry>
    )
  }
}

const mapStateToProps = state => ({
  images: getImages(state)
})

const mapDispatchToProps = null

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(List)

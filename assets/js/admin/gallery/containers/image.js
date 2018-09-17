import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { deleteImage } from '../actions/images'

export class Image extends Component {
  static propTypes = {
    id: PropTypes.string.isRequired,
    src: PropTypes.string.isRequired,
    deleteImage: PropTypes.func.isRequired
  }

  render() {
    const { src } = this.props

    return (
      <div className="gallery-image">
        <button className="delete" onClick={() => this.onClickDelete()} />
        <img src={src} />
      </div>
    )
  }

  onClickDelete() {
    const { id, deleteImage } = this.props
    deleteImage(id)
  }
}

const mapStateToProps = null

const mapDispatchToProps = dispatch => ({
  deleteImage: bindActionCreators(deleteImage, dispatch)
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Image)

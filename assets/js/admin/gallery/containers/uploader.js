import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { getImagesCount } from '../selectors/images'
import { createImage } from '../actions/images'

export class Uploader extends Component {
  static propTypes = {
    isLoading: PropTypes.bool.isRequired,
    imagesCount: PropTypes.number.isRequired,
    createImage: PropTypes.func.isRequired
  }

  render() {
    const { isLoading, imagesCount } = this.props
    return (
      <div className="level">
        <div className="level-left">
          <div className="level-item">
            <div className="field">
              <div className="control">
                {isLoading ? this._renderLoader() : this._renderUploadButton()}
              </div>
            </div>
          </div>
          <div className="level-item">{imagesCount} images</div>
        </div>
      </div>
    )
  }

  _renderUploadButton() {
    return (
      <div className="file is-primary">
        <label className="file-label">
          <input
            className="file-input"
            type="file"
            onChange={e => this.handleChange(e.target.files)}
          />
          <span className="file-cta">
            <span className="file-label">Add image...</span>
          </span>
        </label>
      </div>
    )
  }

  _renderLoader() {
    return <div>Loading...</div>
  }

  handleChange(files) {
    const { imagesCount, createImage } = this.props
    const payloads = Array.from(files).map((file, index) => ({
      position: imagesCount + index + 1,
      file: file
    }))
    payloads.map(payload => createImage(payload))
  }
}

const mapStateToProps = state => ({
  isLoading: state.isLoading,
  imagesCount: getImagesCount(state)
})

const mapDispatchToProps = dispatch => ({
  createImage: bindActionCreators(createImage, dispatch)
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Uploader)

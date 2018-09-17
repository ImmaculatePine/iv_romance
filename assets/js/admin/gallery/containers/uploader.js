import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { getImagesCount } from '../selectors/images'
import { createImage } from '../actions/images'

export class Uploader extends Component {
  static propTypes = {
    imagesCount: PropTypes.number.isRequired,
    createImage: PropTypes.func.isRequired
  }

  render() {
    return (
      <div className="level">
        <div className="level-left">
          <div className="level-item">
            <div className="field">
              <div className="control">
                <div className="file">
                  <label className="file-label">
                    <input
                      className="file-input"
                      type="file"
                      onChange={e => this.handleChange(e.target.files)}
                    />
                    <span className="file-cta">
                      <span className="file-label">Choose a file...</span>
                    </span>
                  </label>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
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
  imagesCount: getImagesCount(state)
})

const mapDispatchToProps = dispatch => ({
  createImage: bindActionCreators(createImage, dispatch)
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Uploader)

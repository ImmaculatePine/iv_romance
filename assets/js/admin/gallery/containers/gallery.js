import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { fetchImages } from '../actions/images'
import Uploader from './uploader'
import List from './list'

export class Gallery extends Component {
  static propTypes = {
    fetchImages: PropTypes.func.isRequired
  }

  componentDidMount() {
    const { fetchImages } = this.props
    fetchImages()
  }

  render() {
    return (
      <div>
        <Uploader />
        <List />
      </div>
    )
  }
}

const mapStateToProps = null

const mapDispatchToProps = dispatch => ({
  fetchImages: bindActionCreators(fetchImages, dispatch)
})

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Gallery)

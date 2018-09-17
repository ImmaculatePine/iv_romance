export const getImages = ({ images }) =>
  images.sort((a, b) => a.position - b.position)

export const getImagesCount = ({ images }) => images.length

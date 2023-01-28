import ScrollTo from 'stimulus-scroll-to'

export default class extends ScrollTo {
  connect() {
    super.connect()
  }

  // You can set default options in this getter for all your anchors.
  get defaultOptions() {
    return {
      offset: 100,
      behavior: 'smooth',
    }
  }
}
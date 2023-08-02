import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field"]
  
  minus() {
      if (this.fieldTarget.value > 0) {
          this.fieldTarget.value --
      }
  }
  
  plus() {
      this.fieldTarget.value ++
  }
}
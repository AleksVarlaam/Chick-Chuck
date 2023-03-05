import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "box", "text", "btn"]
    static values = { ownerId: String }

    connect() {
      if (this.currentUserId && this.currentUserId === this.authorId) {
        this.boxTarget.classList.add("justify-end", "ml-3")
        this.textTarget.classList.add("bg-blue-400", "rounded-bl-3xl", "rounded-tl-3xl", "rounded-tr-xl")
      } else {
        this.boxTarget.classList.add("justify-start", "ml-3")
        this.textTarget.classList.add("bg-gray-400", "rounded-br-3xl", "rounded-tr-3xl", "rounded-tl-xl")
        this.btnTarget.classList.add("hidden")
      }
    }

    get currentUserId() {
      return document.querySelector("[name='current-user-id']").content
    }

    get authorId() {
      return this.ownerIdValue
    }

    clearInput() {
      this.element.reset()
    }
}
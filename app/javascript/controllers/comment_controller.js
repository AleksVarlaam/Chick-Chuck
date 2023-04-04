import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "box", "owner", "admin" ]
    static values = { ownerId: String }

    connect() {
      if (this.currentUserId && this.currentUserId === this.authorId) {
        this.ownerTarget.classList.remove("hidden")
      } else if (this.currentUserType === "Admin"){
        this.adminTarget.classList.remove("hidden")
      } else if (this.currentUserId == 0)  {
        this.boxTarget.classList.add("hidden")
      }
    }

    get currentUserId() {
      return document.querySelector("[name='current-user-id']").content
    }
    
    get currentUserName() {
      return document.querySelector("[name='current-user-name']").content
    }
    
    get currentUserType() {
      return document.querySelector("[name='current-user-type']").content
    }

    get authorId() {
      return this.ownerIdValue
    }

    clearInput() {
      this.element.reset()
    }
}
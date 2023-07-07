import { Application } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"
import "controllers"
import "flowbite";

const application   = Application.start()
window.Stimulus     = application
export { application }
application.debug   = false
Turbo.session.drive = true

// Hotwire/Turbo 1.4.0 redirect
document.addEventListener("turbo:frame-missing", (event) => {
  const { detail: { response, visit } } = event;
  event.preventDefault();
  visit(response.url);
});


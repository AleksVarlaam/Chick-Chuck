import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
import "controllers"

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = true

import "trix"
import "@rails/actiontext"

import 'flowbite';

// Hotwire/Turbo 1.4.0 redirect
document.addEventListener("turbo:frame-missing", (event) => {
  const { detail: { response, visit } } = event;
  event.preventDefault();
  visit(response.url);
});
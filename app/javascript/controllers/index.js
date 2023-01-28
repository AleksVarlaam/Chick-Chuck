// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

import Dropdown from 'stimulus-dropdown'
application.register('dropdown', Dropdown)

import Popover from 'stimulus-popover'
application.register('stimulus-popover', Popover)

import ScrollTo from 'stimulus-scroll-to'
application.register('scroll-to', ScrollTo)

import MessageController from "./message_controller.js"
application.register("message", MessageController)

import CommentController from "./comment_controller.js"
application.register("comment", CommentController)

import ScrollController from "./scroll_controller.js"
application.register("scroll", ScrollController)
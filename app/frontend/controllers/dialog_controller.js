import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  closeOnSuccess(event) {
    if (event.detail.success) {
      this.element.close();
    }
  }
}

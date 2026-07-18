import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  open(event) {
    event.preventDefault();

    const dialog = document.getElementById("delete_modal");
    const confirmBtn = document.getElementById("confirm_delete_btn");

    const form = confirmBtn.closest('form')
    form.action = this.urlValue;

    dialog.showModal();
  }
}

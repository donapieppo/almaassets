import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "uniboDescription" ]

  showUniboDescription (e) {
    toggleVisible(this.uniboDescriptionTarget);
  }

  connect() {
    // console.log("connect good");
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "input", "results" ]

  connect() {
    document.addEventListener('keydown', this.setFocus.bind(this));
  }

  setFocus(event) {
    if (event.key === '/') {
      event.preventDefault(); // Prevent the default '/' key action.
      this.inputTarget.focus(); // Focus on the search input.
    }
  }

  disconnect() {
    // Remove the event listener when the controller is disconnected.
    document.removeEventListener('keydown', this.setFocus.bind(this));
  }

  perform(event) {
    const url = `/search?query=${this.inputTarget.value}`

    fetch(url)
      .then(response => response.text())
      .then(html => {
        if (this.inputTarget.value !== '') {
          this.resultsTarget.innerHTML = html
        } else {
          this.resultsTarget.innerHTML = '';
        }
      })
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = [ "input", "results" ]

  connect() {
    //console.log("Connected to SearchController")
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

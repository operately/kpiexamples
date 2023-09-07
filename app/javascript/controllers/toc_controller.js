import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    root: String
  }

  connect() {
    this.generateTOC();
  }

  generateTOC() {
    let article = document.querySelector(this.rootValue || "article");
    let headings = article.querySelectorAll("h2");

    headings.forEach((heading) => {
      let id = heading.getAttribute('id');
      let text = heading.textContent;
      let tag = heading.tagName;

      if (tag == "H2") {
        this.element.innerHTML += `<a href="#${id}" class="text-operately-blue hover:text-operately-dark-blue underline">${text}</a><br>`;
      } else if (tag == "H3") {
        this.element.innerHTML += `&nbsp;&nbsp;<a href="#${id}" class="text-operately-blue hover:text-operately-dark-blue underline">${text}</a><br>`;
      }
      // Add more conditions if you have h4, h5, etc.
    });
  }
}

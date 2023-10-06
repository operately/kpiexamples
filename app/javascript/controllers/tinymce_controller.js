import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.initEditor();
  }

  disconnect() {
    this.destroyEditor();
  }

  initEditor() {
    setTimeout(() => { // ugly but it works
      if (window.tinymce) {
        tinymce.init({
          target: this.element,
          toolbar: [ 'styleselect | bold italic | bullist numlist | link | undo redo' ],
          plugins: 'lists link',
          menubar: false,
          statusbar: false,
          height: 220,
          default_link_target: '_blank',
          link_assume_external_targets: 'https'
        });
      }
    }, 500);
  }

  destroyEditor() {
    if (window.tinymce) {
      const editor = tinymce.get(this.element.id);
      if (editor) {
        editor.remove();
      }
    }
  }
}


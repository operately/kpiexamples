import { Controller } from "@hotwired/stimulus";

// This controller exists so that we avoid race conditions with Turbo.  We
// don't need to explicitly handle Turbo events. When an element (textarea)
// associated with this controller gets connected or disconnected from the
// DOM, these methods will be automatically called, initializing or destroying
// the TinyMCE instance as appropriate.
export default class extends Controller {
  connect() {
    this.initEditor();
  }

  disconnect() {
    this.destroyEditor();
  }

  initEditor() {
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


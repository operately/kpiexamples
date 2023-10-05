import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggleReplyForm(event) {
    event.preventDefault();

    // Get the reply link that was clicked
    const clickedReplyLink = event.currentTarget;

    // Find the closest reply form relative to the clicked reply link
    const associatedReplyForm = clickedReplyLink.nextElementSibling;

    // Toggle the display of the associated reply form
    associatedReplyForm.style.display = (associatedReplyForm.style.display === "none") ? "block" : "none";
  }

  toggleEditCommentForm(event) {
    event.preventDefault();

    // Find the closest edit form relative to the clicked edit link
    const clickedEditLink = event.currentTarget;
    const formContainer = clickedEditLink.nextElementSibling;

    // Toggle the display of the edit form
    formContainer.style.display = (formContainer.style.display === "none") ? "block" : "none";

    if (formContainer.style.display == "block") {
      // Focus on the text area
      const commentId = clickedEditLink.closest("[data-comment-id]").dataset.commentId;
      this.focusOnTinyMCE(commentId);
    }
  }

  hideEditForm(event) {
    event.preventDefault();

    const clickedHideLink = event.currentTarget;
    const formContainer = clickedHideLink.closest(".edit_form");

    if (formContainer) {
      formContainer.style.display = "none";
    }
  }

  focusOnTinyMCE(commentId) {
    const editorId = "comment_editor_" + commentId;
    const editor = tinymce.get(editorId);

    if (editor) {
      editor.focus();
    }
  }

  checkSubmission(event) {
    const editorContent = tinyMCE.activeEditor.getContent();

    if (!editorContent || editorContent.trim() === '') {
      event.preventDefault();
      alert("Comment cannot be empty.");
      return false;
    }
  }

}

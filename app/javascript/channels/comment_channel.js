import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    const html = `<div class="comments">
    <div class="comment-name">
        ${data.nickname}:
    </div>
        ${data.content.text}  
      </div>`;
    
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('text');
    comments.insertAdjacentHTML('afterbegin', html);
    newComment.value='';
  }
});

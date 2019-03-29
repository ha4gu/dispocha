const room_code_from_path = location.pathname.replace('/rooms/','');
App.chat = App.cable.subscriptions.create(
  { channel: "ChatChannel", room_code: room_code_from_path }, {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    let posts = document.getElementById("room_posts");
    posts.insertAdjacentHTML('afterbegin', data['message']);
  },

  speak: function(input) {
    return this.perform('speak', { content: input });
  }
});

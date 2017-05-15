App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    $("#messages").removeClass('hidden')
    $('#messages').append(this.renderMessage(data));
    var d = $('#messages');
		d.scrollTop(d.prop("scrollHeight"));
    return true;
  },

  renderMessage: function(data) {
    return "<p style='font-size: large;'> <b>" + data.user + ": </b>" + data.message + "</p>";
  }
});

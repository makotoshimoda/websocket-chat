$(document).ready(function() {
  cleanMessage();
  var d = $('#messages');
	d.scrollTop(d.prop("scrollHeight"));
});

function cleanMessage(){
  $("#message-bt").click(function(event){
  	$("#submit-message").click();
    $('#message-text').val('');
  });

  $('#message-text').keydown(function(event) {
    if (event.keyCode == 13) {
      $("#submit-message").click();
      $('#message-text').val('');
     }
  });
}

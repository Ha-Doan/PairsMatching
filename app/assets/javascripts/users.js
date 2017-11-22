var date = document.querySelectorAll('input[type=date]'

function submitDate(event) {
  event.preventDefault();
  findMatch($("#match_date").val());
  $("#match_date").val(null);

}


$(document).ready(function() {
  $("form").bind('submit', submitDate);
});


function switchRole() {

  $.ajax({
    type: "POST",
    url: "/users.json"
    data: JSON.stringify({
    }),
    contentType: "apllication/json",
    dataType: "json"
  })
  .done(functio(data) {
    console.log(data);
  })

}



function submitSwitch(event) {
  event.preventDefault();
  $.when($(".succes").update())
}

end


$(document).ready(function() {
  $("form").bind('click', submitSwitch);
});

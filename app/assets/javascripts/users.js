// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//

$(document).ready(function() {

function readUrl(input) {
    if(input.files && input.files[0] ) {
        var reader = new FileReader();
        reader.onload = function(e) {
            $('#user_picture').attr('src',e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
}
$('#user_avatar').change(function() {
    readUrl(this);
});

$("#query").typeahead( {
    name:
}


});

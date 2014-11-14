// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
//

onLoad(function() {

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

    var orga = new Bloodhound ( {
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        limit: 10,
        prefetch: {
            url: '/organizations/list',
            filter: function(list) {
                return $.map(list, function(organization) { return { name: organization }; });
            }
        }
    });

    orga.initialize()

        $("#user_org_name").typeahead(null, {

            name: "orga",
            displayKey: 'name',
            source : orga.ttAdapter()
                //remote: "/organizations/auto_complete?query=%QUERY"

        });


});



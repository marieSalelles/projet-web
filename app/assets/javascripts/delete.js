//delete object via link which have a data-url

jQuery.each( [ "put", "delete" ], function( i, method ) {
    /*on définit que method est une fonction */
    jQuery[ method ] = function( url, data, callback, type ) {
        if ( jQuery.isFunction( data ) ) {
            type = type || callback;
            callback = data;
            data = undefined;
        }

        return jQuery.ajax({
            url: url,
            type: method,
            dataType: type,
            data: data,
            success: callback
        });
    };
});

$(document).on('click', '.linkOD', function (e) {
    if (confirm('Vous êtes sur de vouloir supprimer ?')){
        /*delete object dans reception response for refresh page*/
        $.delete($(this).data().url, function(data){
            $('#'+data.id).remove();
        });
    }
});

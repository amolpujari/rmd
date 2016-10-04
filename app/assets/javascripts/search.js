var rmdSearching = false;
var lastSearched;

function rmdSearchByValue(q){
  $("[name='q']").val(q);
  rmdSearch();
}

function rmdSearch(e){
    var target = $("[name='q']")[0];

    if (e){
      e.preventDefault();
      e.stopPropagation();
      target = e.target;
    }

    var q = $("[name='q']").val();

    if (q.length < 3){
      return false;
    }

    var resources = $(target).data('search');
    if (resources){
      resources = resources.split(' ');
    }else{
      console.log('no search resource defined.');
    }

    if (rmdSearching==true){
      console.log('rmdSearching true')
      return false;
    }
    rmdSearching = true;
    setTimeout(function(){
      rmdSearching = false;
    }, 1000);

    if (lastSearched){
      if (lastSearched==q){
        console.log('lastSearched same')
        return false;
      }
    }
    lastSearched = q;

    $.each( resources, function(idx, resource){
      rmdSearchResource(resource, q);
    });

    return false;
}

function rmdSearchResource(resource, q){
  var url = '/'+resource+'?q='+q;
  $.getJSON( url, function(json){
    rmdSearchRenderJSON(json);
  });
}

function rmdSearchRenderJSON(json) {
  var template = _.template( $('[data-resource-template="'+json.info.resource+'"]').html() );
  var $holder = $('[data-resource-holder="'+json.info.resource+'"]')
  $holder.html('');

  //$('[data-resource-'+json.info.resource+'-count]').html( (json.info.count || json.data.length) + ' found.')

  $.each( json.data, function(idx, record){
    $holder.append( template(record) );
  });

  hideSpinner();
}


(function(){
  $('[data-resource-template]').hide();

  _.templateSettings = {
    interpolate: /\{\{(.+?)\}\}/g
  };

  rmdSearching = false;
  lastSearched = null;

  $("[name='q']").val('bags');
  rmdSearch();
  $("[name='q']").val('');

})();

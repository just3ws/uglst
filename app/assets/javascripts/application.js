//= require function-prototype-bind-polyfill
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require underscore
//= require md5
//= require bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require ahoy
//= require_tree .


try {
  ahoy.trackAll();
} catch (ex) {
  console.log(ex);
}

function renderBackgroundGoogleMaps(position) {
  try {
    // The latitude and longitude of your business / place
    if (position == null) {
      position = [37.472189, -122.190191];
    }

    function showGoogleMaps() {
      var latLng = new google.maps.LatLng(position[0], position[1]);

      var mapOptions = {
        zoom: 16, // initialize zoom level - the max value is 21
        streetViewControl: false, // hide the yellow Street View pegman
        scaleControl: true, // allow users to zoom the Google Map
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        center: latLng
      };

      map = new google.maps.Map(document.getElementById('googlemaps'),
                                mapOptions);

                                // Show the default red marker at the location
                                marker = new google.maps.Marker({
                                  position: latLng,
                                  map: map,
                                  draggable: false,
                                  animation: google.maps.Animation.DROP
                                });
    }

    google.maps.event.addDomListener(window, 'load', showGoogleMaps);
  } catch (e) {
    console.log(e);
  }
}

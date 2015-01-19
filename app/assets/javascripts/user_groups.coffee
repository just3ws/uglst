$(document).ready ->
  $("#user_group_address").geocomplete
    map: $("#googlemaps-mini")
    autoselect: true
    location: [
      37.472189
      -122.190191
    ]
    maxZoom: 16
    mapOptions:
      zoom: 16 # initialize zoom level - the max value is 21
      zoomControl: false
      maxZoom: 16
      minZoom: 16
      panControl: false
      streetViewControl: false # hide the yellow Street View pegman
      scaleControl: false # allow users to zoom the Google Map
      scrollwheel: false
      draggable: false
      mapTypeId: "roadmap"

    markerOptions:
      disabled: true

    geocodeAfterResult: true

  return


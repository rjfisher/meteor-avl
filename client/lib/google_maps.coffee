@gmaps =
  map: null
  currLocation: null
  locationsHandler: false

  initialize: ->
    mapOptions =
      zoom: 18
      minZoom: 12
      center: new google.maps.LatLng(40.044171, -76.313411)
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

    input = document.getElementById('pac-input')
    map.controls[google.maps.ControlPosition.TOP_LEFT].push input

    searchBox = new google.maps.places.SearchBox(input)
    google.maps.event.addListener searchBox, 'places_changed', ->
      places = searchBox.getPlaces()
      if places.length is 0
        toastr.warning 'Location could not be found!'
        return
      if places.length > 1
        toastr.warning 'More than one location was found.'
        return

      place = places[0]
      map.setCenter place.geometry.location
      return

    Deps.autorun ->
      p = Geolocation.currentLocation()
      if p is null
        return

      loc = new google.maps.LatLng(p.coords.latitude, p.coords.longitude)
      map.setCenter loc

      return

    @map = map
    Session.set 'map', true
    return

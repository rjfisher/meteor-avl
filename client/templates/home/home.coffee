liveMarkers = null

Template.home.helpers
  vehicleNotAssigned: ->
    Vehicles.find(user: Meteor.user()._id).count() is 0

Template.home.rendered = ->
  gmaps.initialize() unless Session.get('map')

  Deps.autorun ->
    loc = Geolocation.latLng()
    vehicle = Vehicles.findOne(user: Meteor.user()._id)
    
    return if (loc is null) or (vehicle is null)
    
    location =
      lat: loc.lat
      lon: loc.lng

    Meteor.call 'updateVehicleLocation', location, (error, result) ->
      return toastr.error error.reason if error
      return toastr.success 'Vehicle ' + result.name + ' updated' if result?

    #Metor.call 'addVehicleHistory', vehicle, (error, result) ->
    #  return toastr.error error.reason if error
    #  return toastr.success 'Vehicle ' + result._id + ' history added'

    return

  @liveMarkers = LiveMaps.addMarkersToMap(gmaps.map, [
      cursor: Vehicles.find()
      onClick: ->
        console.log 'Click vehicle ' + @id
      transform: (vehicle) ->
        title: vehicle.name
        position: new google.maps.LatLng(vehicle.loc.lat, vehicle.loc.lon)
        animation: null
        icon: '//maps.google.com/mapfiles/ms/icons/blue-dot.png'
  ])

  return

Template.home.destroyed = ->
  Session.set 'map', false
  return

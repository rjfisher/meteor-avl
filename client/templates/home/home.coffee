liveMarkers = null

Template.home.helpers
  vehicleNotAssigned: ->
    Vehicles.find({user: Meteor.user()._id}).count() is 0

Template.home.rendered = ->
  gmaps.initialize() unless Session.get('map')
    
  @liveMarkers = LiveMaps.addMarkersToMap(gmaps.map, [
      cursor: Vehicles.find()
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

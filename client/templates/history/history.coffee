liveMarkers = null

Template.history.rendered = ->
  gmaps.initialize() unless Session.get('map')

  @liveMarkers = LiveMaps.addMarkersToMap(gmaps.map, [
    cursor: Histories.find()
    onClick: ->
      console.log @name
      return
    transform: (history) ->
      title: history.name
      position: new google.maps.LatLng(history.loc.lat, history.loc.lon)
      animation: null
      icon: '//maps.google.com/mapfiles/ms/icons/green-dot.png'
  ])

  return

Template.history.destroyed = ->
  Session.set 'map', false
  return

Template.history.helpers
  pointCount: ->
    Histories.find().count()

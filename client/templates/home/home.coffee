liveMarkers = null

Template.home.rendered = ->
  gmaps.initialize() unless Session.get('map')
  return

Template.home.destroyed = ->
  Session.set 'map', false
  return

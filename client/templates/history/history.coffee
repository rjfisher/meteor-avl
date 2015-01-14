liveMarkers = null
historicPoints = []

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

  Deps.autorun ->
    index = Session.get 'historyIndex'
    history = @historicPoints[index]

    gmaps.centerOnLocation history.loc

  @historicPoints = Histories.find().fetch()
  Session.set 'historyIndex', 0
  return

Template.history.destroyed = ->
  Session.set 'map', false
  Session.set 'historyIndex', null
  return

Template.history.helpers
  pointCount: ->
    Histories.find().count()

Template.history.events
  'click .btn-start': (e) ->
    Session.set 'historyIndex', 0

  'click .btn-end': (e) ->
    Session.set 'historyIndex', Histories.find().fetch()

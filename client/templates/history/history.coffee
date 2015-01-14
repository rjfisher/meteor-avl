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

  changeHistory = Deps.autorun ->
    index = Session.get 'historyIndex'
    return unless index?
    
    histories = Histories.find().fetch()
    history = histories[index]
    return unless history?

    gmaps.centerOnLocation history.loc

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
    return

  'click .btn-end': (e) ->
    Session.set 'historyIndex', Histories.find().count() - 1
    return
  
  'click .btn-back-one': (e) ->
    index = Session.get 'historyIndex'
    return unless index? and index >= 1
    Session.set 'historyIndex', index - 1
    
  'click .btn-forward-one': (e) ->
    index = Session.get 'historyIndex'
    return unless index? and index < Histories.find().count() - 1
    Session.set 'historyIndex', index + 1

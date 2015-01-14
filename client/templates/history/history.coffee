livePolyline = null

Template.history.rendered = ->
  #Initialize the slider
  $('.slider').noUiSlider(
    start: 0
    connect: 'lower'
    format: wNumb
      decimals: 0
    step: 1
    range:
      min: 0
      max: Histories.find().count() - 1
  )

  # Initialize the map
  gmaps.initialize() unless Session.get('map')

  # Initialize the live line(s)
  LivePolyline.addLineToMap(gmaps.map, [
    cursor: Histories.find()
    transform: (doc) ->
      new google.maps.LatLng(doc.loc.lat, doc.loc.lon)
    ])

  changeHistory = Deps.autorun ->
    index = Session.get 'historyIndex'
    return unless index?

    histories = Histories.find().fetch()
    history = histories[index]
    return unless history?

    #toastr.warning 'Loc: (' + history.loc.lat + ', ' + history.loc.lon + ')'

    gmaps.centerOnLocation history.loc

  Session.set 'historyIndex', 0
  return

Template.history.destroyed = ->
  Session.set 'map', false
  Session.set 'historyIndex', null
  return

Template.history.helpers
  pointDate: ->
    index = Session.get 'historyIndex'
    return unless index?

    histories = Histories.find().fetch()
    history = histories[index]
    return unless history?

    return moment(history.updated).format('dddd, MMMM, Do YYYY, h:mm:ss a')

Template.history.events
  'slide .slider': (e) ->
    Session.set 'historyIndex', $('.slider').val()
    return

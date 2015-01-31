Template.fences.rendered = ->
  gmaps.initialize(true) unless Session.get('map')

Template.fences.destroyed = ->
  Session.set 'selected', null
  Session.set 'map', false
  return

Template.vehicle.events
  'click .list-group-item': (e) ->
    e.preventDefault()

    Session.set 'selected', @_id
    gmaps.centerOnLocation @loc

Template.vehicle.helpers
  active: ->
    id = Session.get 'selected'

    if id is @_id
      'active'
    else
      ''

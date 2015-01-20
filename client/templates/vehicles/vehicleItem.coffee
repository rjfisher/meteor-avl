Template.vehicleItem.events
  'click .list-group-item': (e) ->
    e.preventDefault()

    Session.set 'selected', @_id
    gmaps.centerOnLocation @loc

  'click .btn-default': (e) ->
    e.preventDefault()

    Router.go '/history/' + @name

Template.vehicleItem.helpers
  active: ->
    id = Session.get 'selected'

    if id is @_id
      'active'
    else
      ''

  badgeColor: ->
    m = if Session.get('currTime')? then Session.get('currTime') else moment()
    return 'badge-success' if moment(m).diff(@updated, 'm') < 1
    return 'badge-info' if moment(m).diff(@updated, 'm') < 10
    return 'badge-warning' if moment(m).diff(@updated, 'm') < 30
    return 'badge-danger' if moment(m).diff(@updated, 'm') >= 30

  lastSeen: ->
    moment(@updated).from(Session.get 'currTime')

Template.vehicle.helpers
  owner: ->
    user = Meteor.users.findOne(@user)
    if user? then user.profile.displayName else 'Unassigned'

  lastSeen: ->
    moment(@updated).from(Session.get 'currTime')

  status: ->
    m = if Session.get('currTime')? then Session.get('currTime') else moment()
    return 'success' if moment(m).diff(@updated, 'm') < 1
    return 'info' if moment(m).diff(@updated, 'm') < 10
    return 'warning' if moment(m).diff(@updated, 'm') < 30
    return 'danger' if moment(m).diff(@updated, 'm') >= 30

Template.vehicle.events
  'click .assignVehicle': (e) ->
    Session.set 'assignVehicle', @
    $('#assignVehicleModal').modal('show')

  'click .editVehicle': (e) ->
    Session.set 'editVehicle', @
    $('#editVehicleModal').modal('show')

  'click .delVehicle': (e) ->
    Session.set 'delVehicle', @
    $('#deleteVehicleModal').modal('show')

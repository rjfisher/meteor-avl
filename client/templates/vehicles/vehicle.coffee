Template.vehicle.helpers
  owner: ->
    user = Meteor.users.findOne(@user)
    if user? then user.profile.displayName else 'Unassigned'
  status: ->
    return 'success' if moment().diff(@updated, 'm') < 1
    return 'info' if moment().diff(@updated, 'm') < 10
    return 'warning' if moment().diff(@updated, 'm') < 30
    return 'danger' if moment().diff(@updated, 'm') >= 30

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

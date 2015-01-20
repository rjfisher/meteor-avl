Template.vehicle.helpers
  status: ->
    return 'success' if moment().diff(@updated, 'm') < 1
    return 'info' if moment().diff(@updated, 'm') < 10
    return 'warning' if moment().diff(@updated, 'm') < 30
    return 'danger' if moment().diff(@updated, 'm') >= 30

Template.vehicle.events
  'click .editVehicle': (e) ->
    Session.set 'editVehicle', @
    $('#editVehicleModal').modal('show')

  'click .delVehicle': (e) ->
    Session.set 'delVehicle', @
    $('#deleteVehicleModal').modal('show')

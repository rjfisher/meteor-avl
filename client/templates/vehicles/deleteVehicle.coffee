Template.deleteVehicle.events
  'click .btn-del': (e) ->
    vehicle = Session.get 'delVehicle'

    if not vehicle?
      toastr.error 'Could not determine vehicle for deletion.', 'Deletion Error'
      return

    # Do the deletion
    Meteor.call 'delVehicle', vehicle._id, (error, result) ->
      return toastr.error error.reason if error
      toastr.success 'Vehicle was sucessfully deleted'
      Session.set 'delVehicle', null
      $('#deleteVehicleModal').modal('hide')

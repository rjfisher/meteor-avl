Template.assignVehicle.events
  'submit form': (e) ->
    e.preventDefault()

    name = $(e.target).find('[name=name]').val()

    vehicle = Session.get 'assignVehicle'

    if not vehicle?
      toastr.error 'Could not determine vehicle for assigning.', 'Error'
      return

    user = Meteor.users.findOne('profile.displayName': name)

    if not user?
      Meteor.call 'unassignVehicle', vehicle._id, (error, result) ->
        return toastr.error error.reason if error
        Session.set 'assignVehicle', null
        $('#assignVehicleModal').modal('hide')
        toastr.success 'Vehicle successfully assigned to no one'
      return

    attrs =
      vehicle: vehicle._id
      user: user._id

    Meteor.call 'assignVehicle', attrs, (error, result) ->
      return toastr.error error.reason if error
      Session.set 'assignVehicle', null
      $('#assignVehicleModal').modal('hide')
      toastr.success 'Vehicle successfully assigned'

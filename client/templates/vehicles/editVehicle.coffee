Template.editVehicle.helpers
  name: ->
    vehicle = Session.get 'editVehicle'
    if vehicle? then vehicle.name else ''

Template.editVehicle.events
  'submit form': (e) ->
    e.preventDefault()

    vehicle = Session.get 'editVehicle'

    if not vehicle?
      toastr.error 'Could not determine vehicle for editing.', 'Editing Error'
      return

    name = $(e.target).find('[name=name]').val()

    attr =
      id: vehicle._id
      name: name

    Meteor.call 'editVehicle', attr, (error, result) ->
      return toastr.error error.reason if error
      toastr.success 'Vehicle was sucessfully edited'
      Session.set 'editVehicle', null
      $('#editVehicleModal').modal('hide')

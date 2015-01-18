Template.addVehicle.events
  'submit form': (e) ->
    e.preventDefault()

    name = $(e.target).find('[name=name]').val()

    if not name?
      toastr.error 'Vehicle requires name'
      return

    location = Geolocation.currentLocation()

    vehicle =
      name: name
      organization: Meteor.user().profile.organization
      loc:
        lon: if location? then location.coords.longitude else 0
        lat: if location? then location.coords.latitude else 0

    Meteor.call 'addVehicle', vehicle, (error, result) ->
      return toastr.error error.reason if error
      return toastr.error 'Vehicle already exists' if result.exists
      $('#addVehicleModal').modal('hide')
      return toastr.success 'Vehicle ' + result._id + ' added'

    return

Template.addVehicle.rendered = ->
  $('#addVehicleModal').modal('show')
  return

Template.addVehicle.events
  'submit form': (e) ->
    e.preventDefault()

    name = $(e.target).find('[name=name]').val()
    org  = $(e.target).find('[name=organization]').val()

    if name is '' or org is ''
      toastr.error 'Vehicle requires name and organization'
      return

    location = Geolocation.currentLocation()

    vehicle =
      name: name
      organization: org
      loc:
        lon: location.coords.longitude
        lat: location.coords.latitude

    Meteor.call 'addVehicle', vehicle, (error, result) ->
      return toastr.error error.reason if error
      return toastr.error 'Vehicle already exists' if result.exists
      $('#addVehicleModal').modal('hide')
      return toastr.success 'Vehicle ' + result._id + ' added'

    return

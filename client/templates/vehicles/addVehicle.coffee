Template.addVehicle.rendered = ->
  $('#addVehicleModal').modal('show')
  return

Template.addVehicle.events
  'submit form': (e) ->
    e.preventDefault()
    
    # Get the data as needed
    # Save it to the database
    
    $('#addVehicleModal').modal('hide')
    return
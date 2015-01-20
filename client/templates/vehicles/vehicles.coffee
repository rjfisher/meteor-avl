Template.vehicles.helpers
  organization: ->
    Meteor.user().profile.organization

  vehicles: ->
    Vehicles.find()

Template.vehicles.events
  'click .addVehicle': (e) ->
    $('#addVehicleModal').modal('show')

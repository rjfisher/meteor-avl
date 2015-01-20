Template.vehicles.created = ->
  Session.set 'currTime', new Date()

  @handle = Meteor.setInterval(->
    Session.set 'currTime', new Date()
  , 1000)

Template.vehicles.destroyed = ->
  Session.set 'currTime', null
  Meteor.clearInterval(@handle)

Template.vehicles.helpers
  organization: ->
    Meteor.user().profile.organization

  vehicles: ->
    Vehicles.find()

Template.vehicles.events
  'click .addVehicle': (e) ->
    $('#addVehicleModal').modal('show')

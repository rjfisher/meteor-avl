Template.vehicles.helpers
  organization: ->
    Meteor.user().profile.organization

  vehicles: ->
    Vehicles.find()

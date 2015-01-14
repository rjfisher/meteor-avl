Meteor.publish 'vehicles', ->
  Vehicles.find()

Meteor.publish 'history', (name) ->
  check name, String

  Histories.find name: name

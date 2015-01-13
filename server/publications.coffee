Meteor.publish 'vehicles', ->
  Vehicles.find()

Meteor.publish 'history', (name) ->
  check name, String

  console.log 'Searching for ' + name
  Histories.find({},
    name: name,
    sort:
      updated: -1
  )

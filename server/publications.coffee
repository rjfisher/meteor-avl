Meteor.publish 'vehicles', ->
  Vehicles.find()

Meteor.publish 'history', (name) ->
  check name, String

  Histories.find name: name

Meteor.publish 'users-list', (org) ->
  check org, String

  Meteor.users.find {'profile.organization': org},
    fields:
      username: 1
      profile: 1

Meteor.publish 'vehicles', (org) ->
  check org, String

  Vehicles.find
    'organization': org

Meteor.publish 'history', (name) ->
  check name, String

  Histories.find
    name: name

Meteor.publish 'users-list', (org) ->
  check org, String

  Meteor.users.find
    'profile.organization': org,
    fields:
      emails: 1
      username: 1
      profile: 1

Meteor.publish 'messages', (id) ->
  check id, String

  Messages.find
    to: id

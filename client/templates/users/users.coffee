Template.users.helpers
  organization: ->
    Meteor.user().profile.organization

  users: ->
    Meteor.users.find()

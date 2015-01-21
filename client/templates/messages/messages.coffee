Template.messages.helpers
  username: ->
    if Meteor.user() then Meteor.user().profile.displayName else 'unknown'

  messages: ->
    Messages.find()

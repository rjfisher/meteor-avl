Template.messages.helpers
  username: ->
    if Meteor.user() then Meteor.user().profile.displayName else 'unknown'

  messages: ->
    Messages.find()

Template.messages.events
  'click .addMessage': (e) ->
    $('#addMessageModal').modal('show')

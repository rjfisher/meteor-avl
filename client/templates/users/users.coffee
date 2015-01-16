Template.users.helpers
  organization: ->
    Meteor.user().profile.organization

  users: ->
    Meteor.users.find()

Template.users.events
  'click .addUser': (e) ->
    $('#addUserModal').modal('show')
    

Template.layout.helpers
  displayName: ->
    if Meteor.user() then Meteor.user().profile.displayName else ''
  isAdmin: ->
    if Meteor.user() then Meteor.user().profile.isAdmin else false

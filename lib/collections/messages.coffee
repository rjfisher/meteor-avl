@Messages = new Mongo.Collection 'message'

Meteor.methods
  addMessage: (params) ->
    check params, Object
    return

  markRead: (params) ->
    check params, Object
    return

  deleteMessage: (params) ->
    check params, Object
    return

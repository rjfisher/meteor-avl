@Messages = new Mongo.Collection 'message'

Meteor.methods
  addMessage: (params) ->
    check params, Object

    emails = params.emails.split(' ')
    _.each emails, (email) ->
      u = Meteor.users.findOne emails:
        $elemMatch:
          address:
            email

      # Email address doesn't exist so don't send a message.
      # Prevents adding to database in case a user with that email
      # Does show up some day.
      if not u?
        return

      # Add message to the database
      message =
        to: email
        from: Meteor.user().emails[0].address
        subject: params.subject
        body: params.body
        date: new Date()
        read: false

      Messages.insert message

  markRead: (id) ->
    check id, String

    message = Messages.findOne id

    if not message?
      throw new Meteor.Error 404, 'Message could not be found in system.'

    if not message.user is Meteor.userId()
      # The user is not in the same organization, not allowed
      throw new Meteor.Error 401, 'This message was not sent do you.'

    Messages.update message._id,
      $set:
        read: true

  deleteMessage: (id) ->
    check id, String

    message = Messages.findOne id

    if not message?
      throw new Meteor.Error 404, 'Message could not be found in system.'

    if not message.user is Meteor.userId()
      # The user is not in the same organization, not allowed
      throw new Meteor.Error 401, 'You can only delete your own message.'

    Messages.remove _id: id

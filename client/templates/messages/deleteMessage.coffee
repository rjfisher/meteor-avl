Template.deleteMessage.events
  'click .btn-delete': (e) ->
    #e.preventDefaults()

    message = Session.get 'delMessage'

    if not message?
      toastr.error 'Could not determine message for deletion', 'Deletion Error'
      return

    Meteor.call 'deleteMessage', message._id, (error, result) ->
      return toastr.error error.reason if error
      toastr.success 'Messages was sucessfully deleted'
      Session.set 'delMessage', null
      $('#deleteMessageModal').modal('hide')

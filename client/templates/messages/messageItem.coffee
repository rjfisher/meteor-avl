Template.messageItem.helpers
  status: ->
    if @read then 'active' else 'success'

Template.messageItem.events
  'click .read': (e) ->
    Session.set 'readMessage', @
    $('#readMessageModal').modal('show')
    Meteor.call 'markRead', @_id, (error, result) ->
      return toastr.error error.reason if error
      #toastr.success 'Message was successfully marked as read'

  'click .reply': (e) ->
    return

  'click .delete': (e) ->
    Session.set 'delMessage', @
    $('#deleteMessageModal').modal('show')

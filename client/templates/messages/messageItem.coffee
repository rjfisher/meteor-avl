Template.messageItem.helpers
  status: ->
    if @read then 'active' else 'success'

Template.messageItems.events
  'click read': (e) ->
    return

  'click reply': (e) ->
    return

  'click delete': (e) ->
    Session.set 'delMessage', @
    $('#deleteMessageModal').modal('show')

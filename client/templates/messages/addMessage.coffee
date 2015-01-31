Template.addMessage.events
  'form submit': (e) ->
    e.preventDefaults()

    emails = $(e.target).find('[name=emails]').val()
    subject = $(e.target).find('[name=subject]').val()
    text = $(e.target).find('[name=messageText]').val()

    if not emails? or subject? or text?
      toastr.error 'Error creating new message', 'Error'
      return

    params =
      emails: emails
      subject: subject
      text: text

    Meteor.call 'addMessage', params, (error, result) ->
      return toastr.error error.reason if error
      toastr.success 'Message was successfully send'
      $('#addMessageModal').modal('hide')

Template.deleteUser.events
  'submit form': (e) ->
    e.preventDefault()

    user = Session.get 'delUser'

    if not user?
      toastr.error 'Could not determine user for deletion.', 'Deletion Error'
      return

    # Do the deletion
    Meteor.call 'delUser', user, (error, result) ->
      return toastr.error error.reason if error
      toastr.success 'User was sucessfully deleted'
      Session.set 'delUser', null
      $('#deleteUserModal').modal('hide')

Template.editUser.helpers
  displayName: ->
    userId = Session.get 'editUser'
    return unless userId?

    user = Meteor.users.findOne(userId)
    return unless user?

    user.profile.displayName

  isAdmin: ->
    userId = Session.get 'editUser'
    return unless userId?

    user = Meteor.users.findOne(userId)
    return unless user?

    user.profile.isAdmin

Template.editUser.events
  'submit form': (e) ->
    e.preventDefault()

    userId = Session.get 'editUser'
    user = Meteor.users.findOne(userId)

    if not user?
      toastr.error 'Could not determine user for editing.', 'Editing Error'
      return

    name = $(e.target).find('[name=displayName]').val()
    t = $(e.target).find('[name=admin]:checked').val()
    isAdmin = (if (t is 'on') then true else false)

    updates =
      id: userId
      displayName: name
      isAdmin: isAdmin

    # Update the user
    Meteor.call 'editUser', updates, (error, result) ->
      return toastr.error error.reason if error
      toastr.success 'User was successfully updated'
      Session.set 'editUser', null
      $('#editUserModal').modal('hide')

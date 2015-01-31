Template.user.helpers
  isUser: ->
    (if @_id is Meteor.userId() then 'warning' else '')
  name: ->
    return 'unknown' unless @profile.displayName?
    @profile.displayName
  email: ->
    return 'unknown' unless @emails? and @emails[0]?
    @emails[0].address
  role: ->
    return 'unknown' unless @profile.isAdmin?
    if @profile.isAdmin
      return 'admin'
    else
      return 'user'

Template.user.events
  'click .delUser': (e) ->
    # We want to be able to delete ourselved
    if @_id is Meteor.userId()
      Session.set 'delUser', @_id
      $('#deleteUserModal').modal('show')
      return

    # We want to forbid deleting other admins
    if @profile.isAdmin
      toastr.error 'You cannot delete another administrator.', 'Deletion Error'
      return

    # Set who is going to get deleted and show template
    Session.set 'delUser', @_id
    $('#deleteUserModal').modal('show')

Template.user.events
  'click .editUser': (e) ->
    # We only want to allow editing by admins
    if not Meteor.user().profile.isAdmin
      toastr.error 'Only admins can edit users.', 'Editing Error'
      return

    Session.set 'editUser', @_id
    $('#editUserModal').modal('show')

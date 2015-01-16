Template.addUser.events
  'submit form': (e) ->
    e.preventDefault()

    email = $(e.target).find('[name=username]').val()
    password = $(e.target).find('[name=password]').val()
    name = $(e.target).find('[name=displayName]').val()
    organization = Meteor.user().profile.organization
    t = $(e.target).find('[name=admin]:checked').val()
    isAdmin = (if (t is 'on') then true else false)

    options =
      email: email
      password: password
      profile:
        displayName: name
        isAdmin: isAdmin
        organization: organization

    Meteor.call 'addUserToOrganization', options, (error, result) ->
      return toastr.error error.reason if error
      toastr.success name + ' was added to your organization'
      $('#addUserModal').modal('hide')

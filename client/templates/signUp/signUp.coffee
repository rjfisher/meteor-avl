Template.signUp.events
  'submit form': (e) ->
    e.preventDefault()

    email = $(e.target).find('[name=username]').val()
    password = $(e.target).find('[name=password]').val()
    displayName = $(e.target).find('[name=displayName]').val()
    organization = $(e.target).find('[name=organization]').val()

    Accounts.createUser
      email: email
      password: password
      profile:
        displayName: displayName
        isAdmin: true
        organization: organization
      , (error) ->
        if error
          toastr.error('Could not add user: ', + error.reason, 'Error!')
        else
          toastr.success('Welcome to the AVL site', 'Added user')
          Router.go 'home'

Template.signIn.events
  'submit form': (e) ->
    e.preventDefault()

    email = $(e.target).find('[name=username]').val()
    password = $(e.target).find('[name=password]').val()

    Meteor.loginWithPassword email, password, (error) ->
      if (error)
        toastr.error('Could not log in: ', + error.reason, 'Error!')
      else
        Router.go 'home'

Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'

Router.route '/sign-up',
  name: 'signUp'
  template: 'signUp'

Router.route '/sign-in',
  name: 'signIn'
  template: 'signIn'

Router.route '/log-out',
  name: 'logOut'
  action: ->
    if Meteor.user()
      Meteor.logout ->
        Router.go 'home'
    else
      Router.go 'home'

Router.route '/',
  name: 'home',
  waitOn: ->
    Meteor.subscribe 'vehicles'
  action: ->
    if Meteor.user()
      @render 'home'
    else
      @render 'about'

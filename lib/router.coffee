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

Router.route '/history/:name',
  name: 'history'
  waitOn: ->
    Meteor.subscribe 'history', @params.name
  action: ->
    if Meteor.user()
      @render 'history'
    else
      @render 'about'

Router.route '/',
  name: 'home',
  waitOn: ->
    Meteor.subscribe 'vehicles'
  action: ->
    if Meteor.user()
      @render 'home'
    else
      @render 'about'

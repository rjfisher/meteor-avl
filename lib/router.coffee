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

Router.route '/profile/:id',
  name: 'profile'
  action: ->
    if Meteor.user()
      @render 'profile'
    else
      @render 'about'

Router.route '/users',
  name: 'users'
  waitOn: ->
    return unless Meteor.user()
    Meteor.subscribe 'users-list', Meteor.user().profile.organization
  action: ->
    if Meteor.user()
      @render 'users'
    else
      @render 'about'

Router.route '/vehicles',
  name: 'vehicles'
  waitOn: ->
    return unless Meteor.user()
    Meteor.subscribe 'vehicles', Meteor.user().profile.organization
  action: ->
    if Meteor.user()
      @render 'vehicles'
    else
      @render 'about'

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
    return unless Meteor.user()
    Meteor.subscribe 'vehicles', Meteor.user().profile.organization
  action: ->
    if Meteor.user()
      @render 'home'
    else
      @render 'about'

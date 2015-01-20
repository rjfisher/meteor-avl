Template.vehicleList.created = ->
  Session.set 'currTime', new Date()

  @handle = Meteor.setInterval(->
    Session.set 'currTime', new Date()
  , 1000)

Template.vehicleList.destroyed = ->
  Session.set 'currTime', null
  Meteor.clearInterval(@handle)

Template.vehicleList.helpers
  vehicleCount: ->
    Vehicles.find().count()

  vehicles: ->
    Vehicles.find(name:
      $regex: Session.get 'filter'
      $options: 'i'
    )

Template.vehicleList.events
  'keyup input.form-control': (e) ->
    Session.set 'filter', $(e.target).val()

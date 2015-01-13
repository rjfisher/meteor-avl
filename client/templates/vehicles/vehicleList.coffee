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

Template.vehicleList.helpers
  vehicleCount: ->
    Vehicles.find().count()
    
  vehicles: ->
    Vehicles.find()

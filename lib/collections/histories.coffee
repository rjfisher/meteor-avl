@Histories = new Mongo.Collection 'history'

Meteor.methods
  addVehicleHistory: (vehicle) ->
    check Meteor.userId(), String
    check vehicle, Object

    if not vehicle.user is Meteor.userId()
      throw new Meteor.Error 401, 'Invalid User', 'You do not own this vehicle'

    seconds = (new Date().getTime() - vehicle.updated) / 1000
    return unless seconds > 5

    history =
      name: vehicle.name
      organization: vehicle.organization
      added: vehicle.added
      updated: vehicle.updated
      user: vehicle.user
      vehicle: vehicle._id
      loc:
        lon: vehicle.loc.lon
        lat: vehicle.loc.lat

    id = Histories.insert history
    name: history.name

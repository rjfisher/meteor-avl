@Vehicles = new Mongo.Collection('vehicles',
  transform: (doc) ->
    doc.lastSeen = ->
      seen = moment(@updated)
      seen.fromNow()

    doc
)

Meteor.methods
  addVehicle: (vehicleAttrs) ->
    check Meteor.userId(), String
    check vehicleAttrs,
      name: String
      organization: String
      loc: Object

    exists = Vehicles.findOne(name: vehicleAttrs.name)
    if exists
      return (
        exists: true
        _id: exists._id
      )

    # Only admins should be adding vehicles
    user = Meteor.user()
    if not user.profile.isAdmin
      throw new Meteor.Error 'Only administrators can add vehicles'

    vehicle = _.extend(vehicleAttrs,
      added: new Date()
      updated: new Date()
      user: null
    )

    id = Vehicles.insert(vehicle)
    _id: id

  delVehicle: (id) ->
    check id, String

    vehicle = Vehicles.findOne(id)

    if not vehicle?
      throw new Meteor.Error('Vehicle could not be found in system.')

    if not Meteor.user().profile.isAdmin
      # They aren't an admin, return error
      throw new Meteor.Error('Only administrators may remove users.')

    if not Meteor.user().profile.organization is vehicle.organization
      # The user is not in the same organization, not allowed
      throw new Meteor.Error('You can only delete organization vehicles.')

    console.log 'vehicle id = ' + id

    Vehicles.remove(_id: id)

  editVehicle: (vehicleAttrs) ->
    check vehicleAttrs, Object

    vehicle = Vehicles.findOne(vehicleAttrs.id)

    if not vehicle?
      throw new Meteor.Error('Vehicle could not be found in system.')

    if not Meteor.user().profile.isAdmin
      # They aren't an admin, return error
      throw new Meteor.Error('Only administrators may remove users.')

    if not Meteor.user().profile.organization is vehicle.organization
      # The user is not in the same organization, not allowed
      throw new Meteor.Error('You can only delete organization vehicles.')

    Vehicles.update vehicle._id,
      $set:
        name: vehicleAttrs.name

  updateVehicleLocation: (location) ->
    check Meteor.userId(), String
    check location,
      lat: Number,
      lon: Number

    vehicle = Vehicles.findOne(user: Meteor.userId())

    seconds = (new Date().getTime() - vehicle.updated) / 1000
    return unless seconds > 5

    return if not vehicle?

    Vehicles.update vehicle._id,
      $set:
        loc: location
        updated: new Date()

    name: vehicle.name

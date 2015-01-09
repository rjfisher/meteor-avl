@Vehicles = new Mongo.Collection('vehicles')

@Vehicles.allow
  insert: (userId, doc) ->
    !!userId

Meteor.startup ->
  # Potentially prompts the user to enable location services.  We do this early
  # on in order to have the most accurate location by the tihe the user sees
  # the map.
  Geolocation.currentLocation
  return

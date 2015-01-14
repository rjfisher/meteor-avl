@LivePolyline =
  addLineToMap: (map, cursors) ->
    if not Array.isArray(cursors)
      cursors = [cursors]
    queries = (livePolyline(map, cursor) for cursor in cursors)
    #return method to destroy them when you are done
    return stop: -> do stopQuery for stopQuery in queries

livePolyline = (map, cursor) ->
  coordinates = []
  flightPath = new google.maps.Polyline(
    path: []
    geodesic: true
    strokeColor: '#77FF77'
    strokeOpacity: 0.5,
    strokeWeight: 7
  )

  flightPath.setMap(map)

  if cursor.observe
    transform = (doc) ->
      coordinate = new google.maps.LatLng(
        doc.latitude or doc.lat or doc.location[1],
        doc.longitude or doc.lng or doc.locaiton[0]
      )
  else
    transform = cursor.transform
    cursor = cursor.cursor

  addCoordinate = (doc) ->
    coordinate = transform(doc)
    coordinates[doc._id] =
      coord: coordinate
      index: flightPath.getPath().length
    flightPath.getPath().push coordinate

  updateCoordinate = (newDoc, oldDoc) ->
    # do something here

  removeCoordinate = (doc) ->
    flightPath.getPath().removeAt coordinates[doc._id].index
    delete coordinates[doc._id]

  removeAllCoordinates = ->
    for coordinate in coordinates
      flightPath.getPath().removeAt coordinate.index

  liveQuery = cursor.observe
    added: addCoordinate
    changed: updateCoordinate
    removed: removeCoordinate

  return ->
    do liveQuery.stop
    removeAllCoordinates

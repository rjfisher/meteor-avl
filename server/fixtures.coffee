latMin = 40.00860681
latMax = 40.113712684
lngMin = -76.5542851
lngMax = -75.0334645

#if Vehicles.find({}).count() is 0
#  console.log 'Adding fake vehicle information'
#
#  i = 0
#  while i < 10
#    lat = Math.random() * (latMax - latMin) + latMin
#    lng = Math.random() * (lngMax - lngMin) + lngMin
#
#    id = Vehicles.insert(
#      name: 'Test Vehicle #' + i
#      organization: 'Test Company'
#      added: new Date()
#      user: null
#      loc:
#        lon: lng
#        lat: lat
#    )
#    i++
#
#  Vehicles._ensureIndex loc: '2d'
#  Histories._ensureIndex loc: '2d'

if Messages.find().count() is 0
  id = Messages.insert
    to: 'rfisher@geographit.com',
    from: 'asmart@geographit.com',
    subject: 'This is a test message',
    body: 'This is the body of the message',
    date: new Date()
    read: false

if Vehicles.find().count() is 0
  console.log 'Indexing collections'
  Vehicles._ensureIndex loc: '2d'
  Histories._ensureIndex loc: '2d'
  Fences._ensureIndex loc: '2dsphere'

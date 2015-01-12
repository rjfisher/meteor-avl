Template.vehicle.events
  'click .list-group-item': (e) ->
    e.preventDefault()
    
    console.log 'Clicked ' + @name
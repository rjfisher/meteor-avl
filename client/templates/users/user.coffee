Template.user.helpers
  name: ->
    return 'unknown' unless @profile.displayName?
    @profile.displayName
  email: ->
    return 'unknown' unless @emails? and @emails[0]?
    @emails[0].address
  role: ->
    return 'unknown' unless @profile.isAdmin?
    if @profile.isAdmin
      return 'admin'
    else
      return 'user'

Meteor.methods
  addNewUser: (options) ->
    check options, Object

    # Ideally we would want some billing info in here!

    user = Meteor.users.findOne 'profile.organization': options.organization

    if user?
      throw new Meteor.Error 401, 'Cannot join existing organization.'

    id = Accounts.createUser
      email: options.email
      password: options.password
      profile:
        displayName: options.profile.displayName
        isAdmin: true
        organization: options.profile.organization

    name: options.profile.displayName

  addUserToOrganization: (options) ->
    # Time to create a user
    check options, Object

    if not Meteor.user().profile.isAdmin
      # They aren't an admin, return error
      throw new Meteor.Error 401, 'Only administrators may add new users.'

    if not Meteor.user().profile.organization is options.profile.organization
      # The new user is not in the same organization, not allowed
      throw new Meteor.Error 401, 'You can only add users of the same organization'

    id = Accounts.createUser
      email: options.email
      password: options.password
      profile:
        displayName: options.profile.displayName
        isAdmin: options.profile.isAdmin
        organization: options.profile.organization

    name: options.profile.displayName

  editUser: (options) ->
    check options, Object

    if not Meteor.user().profile.isAdmin
      # They aren't an admin, return error
      throw new Meteor.Error 401, 'Only administrators may edit users.'

    if not Meteor.user().profile.organization is options.organization
      # The new user is not in the same organization, not allowed
      throw new Meteor.Error 401, 'You can only edit users of the same org'

    Meteor.users.update
      _id: options.id
    ,
      $set:
        'profile.displayName': options.displayName
        'profile.isAdmin': options.isAdmin

  delUser: (id) ->
    # Time to mark a user deleted
    check id, String

    user = Meteor.users.findOne(id)
    username = user.profile.displayName

    if not user?
      # User wasn't found! WTF
      throw new Meteor.Error 404, 'User does not exist.'

    if not Meteor.user().profile.isAdmin
      # They aren't an admin, return error
      throw new Meteor.Error 401, 'Only administrators may remove users.'

    if not Meteor.user().profile.organization is user.profile.organization
      # The user is not in the same organization, not allowed
      throw new Meteor.Error 401, 'You can only delete organization members'

    Meteor.users.remove _id: id

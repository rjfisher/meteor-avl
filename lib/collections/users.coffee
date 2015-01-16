Meteor.methods
  addUser: (options) ->
    # Time to create a user
    check options, Object

    if not Meteor.user().profile.isAdmin
      # They aren't an admin, return error
      throw new Meteor.Error('Only administrators may add new users.')

    if not Meteor.user().profile.organization is options.profile.organization
      # The new user is not in the same organization, not allowed
      throw new Meteor.Error('You can only add users of the same organization')

    id = Accounts.createUser
      email: options.email
      password: options.password
      profile:
        displayName: options.profile.displayName
        isAdmin: options.profile.isAdmin
        organization: options.profile.organization

    name: options.profile.displayName

  delUser: (id) ->
    # Time to mark a user deleted
    check id, String

    user = Meteor.users.findOne(id)
    username = user.profile.displayName

    if not user?
      # User wasn't found! WTF
      throw new Meteor.Error('User does not exist.')

    if not Meteor.user().profile.isAdmin
      # They aren't an admin, return error
      throw new Meteor.Error('Only administrators may remove users.')

    if not Meteor.user().profile.organization is user.profile.organization
      # The user is not in the same organization, not allowed
      throw new Meteor.Error('You can only delete organization members')

    result = Meteor.users.remove(_id: id)
    console.log 'Result is ' + username

    name: username

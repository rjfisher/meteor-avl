@Histories = new Mongo.Collection('history')

@Histories.allow
  insert: (userId, doc) ->
    !!userId
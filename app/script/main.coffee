{ createClass } = require 'asteroid'
Asteroid = createClass()
asteroid = new Asteroid
  endpoint: "ws://localhost:3000/websocket"

LOGJ = (name, data) -> @app.message = name + ': ' + JSON.stringify data, null, 2
successMsg = (data) -> LOGJ 'success', data
failureMsg = (data) -> LOGJ 'ups', data

window.onload = ->
  @i = 0
  @app = new Vue
    el: '#app'
    data:
      loggedIn: false
      message: ''
    methods:
      login: ->
        username = 'test'
        promise = asteroid.loginWithPassword {username, 'password'}
        success = (data) ->
          @app.loggedIn = true
          successMsg data
        promise.then(success).catch(failureMsg)
      logout: ->
        promise = asteroid.logout()
        success = (data) ->
          @app.loggedIn = false
          successMsg data
        promise.then(success).catch(failureMsg)
      test: =>
        promise = asteroid.call 'test', {m: @i++}
        promise.then(successMsg).catch(failureMsg)

  asteroid.subscribe("test")

  asteroid.ddp.on "added", ({collection, id, fields}) ->
    if 'test' is collection
      LOGJ 'added', fields

  asteroid.ddp.on "removed", ({collection, id, fields}) ->
    LOGJ 'removed', id

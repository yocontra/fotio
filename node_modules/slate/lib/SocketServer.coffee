{Server} = require 'ws'
{EventEmitter} = require 'events'

class SocketServer extends EventEmitter
  constructor: (@config) ->
  listen: (@server) ->
  
  close: -> socket.close() for socket in @config.sockets
  
  route: (path, fn) ->
    return unless not @config.get 'disableSockets'
    unless @config.sockets[path]?
      @config.sockets[path] = new Server {server: @server, path: path}
    if fn?
      @config.sockets[path].on 'connection', fn
    return @config.sockets[path]
    
module.exports = SocketServer

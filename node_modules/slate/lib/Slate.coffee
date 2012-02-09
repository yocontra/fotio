{EventEmitter} = require 'events'
{normalize} = require 'path'
Config = require './Config'
HttpServer = require './HttpServer'
SocketServer = require './SocketServer'

class Slate extends EventEmitter
  constructor: ->
    @config = new Config
    @http = new HttpServer @config
    @socket = new SocketServer @config
  
  # Convenience
  ## HTTP
  root: (dir) -> @set 'root', normalize dir 
  engine: (args...) -> @http.engine args...
  use: (args...) -> @http.use args...
  enable: (args...) -> @http.enable args...
  disable: (args...) -> @http.disable args...
  
  ## Sockets
  route: (args...) -> @socket.route args...
  
  ## Config
  set: (args...) -> @config.set args... 
  get: (args...) -> @config.get args...
  
  listen: (port, host) ->
    srv = @http.listen port, host
    @socket.listen srv

module.exports = Slate

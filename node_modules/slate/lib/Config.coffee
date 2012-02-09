class Config
  constructor: ->
    @sockets = {}
    @engines = {}
    @mime = {}
    @defaultMiddle = {}
    @middle = [] # array to preserve order
    @production = false
    
  load: (path) -> @set require path
  get: (key) -> @[key] || undefined
  set: (key, val) ->
    val ?= true
    if typeof key is 'object'
      @[key] = val for key, val of obj
    else if typeof key is 'string'
      @[key] = val
    else
      # TODO: Throw error?
    return
  
module.exports = Config

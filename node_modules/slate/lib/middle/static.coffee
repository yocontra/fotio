{readFile} = require 'fs'
{extname} = require 'path'

cache = {}

module.exports = (req, res, next, config) ->
  if req.resolvedPath? and not req.isModule
    return res.end cache[req.resolvedPath] if cache[req.resolvedPath]?
    readFile req.resolvedPath, (err, data) -> 
      return res.deny 500 if err? or !data
      engines = config.get 'engines'
      ext = extname(req.resolvedPath)[1..]
      eng = engines[ext]
      if eng?
        data = eng.compile String(data), eng.data, eng.options
      res.end data
      cache[req.resolvedPath] = data if config.get 'production'
  next()

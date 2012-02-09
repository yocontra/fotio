{lookup} = require 'mime'
{extname} = require 'path'

module.exports = (req, res, next, config) ->
  if req.resolvedPath?
    engines = config.get 'engines'
    ext = extname(req.resolvedPath)[1..]
    if engines[ext]?
      res.setHeader 'Content-Type', config.mime[ext] || 'text/html'
    else
      mime = lookup req.resolvedPath
      res.setHeader 'Content-Type', mime if mime?
  next()

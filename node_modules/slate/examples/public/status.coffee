module.exports = (req, res, next, config) ->
  res.setHeader 'Content-Type', 'text/html'
  res.end 'online'
  next()

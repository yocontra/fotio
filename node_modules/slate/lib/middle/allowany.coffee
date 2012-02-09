module.exports = (req, res, next, config) ->
  res.setHeader 'Access-Control-Allow-Origin', '*'
  res.setHeader 'Access-Control-Allow-Headers', 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Accept, Origin'
  res.setHeader 'Access-Control-Allow-Methods', 'POST, GET, PUT, DELETE, OPTIONS'
  res.setHeader 'Access-Control-Max-Age', 1728000
  next()

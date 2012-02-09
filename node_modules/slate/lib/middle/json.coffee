module.exports = (req, res, next) ->
  return next() if req.parsedJSON
  return next() if "GET" is req.method or "HEAD" is req.method
  
  buf = ""
  req.setEncoding "utf8"
  req.on "data", (chunk) -> buf += chunk

  req.on "end", ->
    try
      req.body = JSON.parse(buf) || {}
      req.parsedJSON = true
      next()
    catch err
      res.end('invalid json')

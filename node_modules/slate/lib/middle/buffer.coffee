module.exports = (req, res, next) ->
  return next() if req.parsedBody
  return next() if "GET" is req.method or "HEAD" is req.method
  req.body = req.body or {}
  req.parsedBody = true
  req.on "data", (chunk) -> req.body += chunk
  req.on "end", -> next()

module.exports = (req, res, next) -> 
  if /application\/j/.test req.headers.accept
    return res.deny() # CSRF-0
    
  else if req.method is "POST" and headers.referer and not (req.headers.referer.indexOf(headers.host + "/") > 0)
    return res.deny() # CSRF-1 - If we get a POST from another site
    
  else if req.method isnt "GET" and req.method isnt "POST"
    return res.deny() # CSRF-2 - If we get a request without a method (This seems a little sloppy, could be improved)
    
  next()

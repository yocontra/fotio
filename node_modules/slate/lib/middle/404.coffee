module.exports = (req, res, next) -> 
  if req.resolvedPath?
    next()
  else
    res.deny 404

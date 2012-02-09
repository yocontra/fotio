xemplar = require 'xemplar'

module.exports = (req, res, next) -> 
  for pattern in xemplar.security.lfi
    if pattern.test req.url
      return res.deny()
  next()

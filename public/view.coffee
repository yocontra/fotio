url = require 'url'
{join, exists, basename} = require 'path'

module.exports = (req, res, next, config) ->
  data = url.parse(req.url, true).query
  return res.end 'Missing fields' unless data? and data.id?
  return res.end 'Invalid id' unless String(data.id).match /^[a-z0-9]+$/i
  images = config.get 'images'
  images.get data.id, (err, image) ->
    return res.end 'Picture does not exist' if err?
    image = JSON.parse image
    res.setHeader 'Content-Type', 'text/html'
    return res.end "<h2>#{image.title} - #{image.filter}</h2><br><img src='#{image.relative}'/>"
manipulator = require './manipulator'
{basename, join} = require 'path'

module.exports = (config, options, cb) ->
  {filter, title, path, ip} = options
  return cb JSON.stringify error: "Invalid filter" unless manipulator[filter]

  imageDir = config.get 'imageDir'
  npath = join imageDir, basename(path)

  manipulator[filter] path, npath, (err) ->
    return cb JSON.stringify error: "Image processing error! - #{err.message}" if err?
    images = config.get 'images'
    id = basename npath
    data =
      relative: "#{basename(imageDir)}/#{id}"
      path: npath
      title: title
      filter: filter
      uploader: ip

    images.add id, JSON.stringify(data), (err) ->
      return cb JSON.stringify error: "Database storage error - #{err.message}" if err?
      return cb null, npath
formidable = require 'formidable'
manipulator = require '../src/manipulator'
{basename, join} = require 'path'

module.exports = (req, res, next, config) ->
  if req.method is 'POST'
    form = new formidable.IncomingForm
    form.keepExtensions = false
    form.uploadDir = config.get 'tempDir'
    form.maxFieldsSize = config.get 'fileLimit'

    form.parse req, (err, fields, files) ->
      return res.end "{'error': 'Error parsing file - #{err.message}'}" if err?
      {title, filter} = fields
      {path, mime, filename, length} = files.upload
      return res.end "{'error': 'Missing fields'}" unless title and filter and mime and filename and length and path
      return res.end "{'error': 'Invalid filter'}" unless manipulator[filter]
      return res.end "{'error': 'Invalid file'}" if mime.indexOf('image/') isnt 0
      imageDir = config.get 'imageDir'
      npath = join imageDir, basename(path)

      manipulator[filter] path, npath, (err) ->
        return res.end "{'error': 'Image processing error! - #{err.message}'}" if err?
        images = config.get 'images'
        id = basename npath
        data =
          relative: "#{basename(imageDir)}/#{id}"
          path: npath
          title: title
          filter: filter
          uploader: req.connection.remoteAddress

        images.add id, JSON.stringify(data), ->
          return res.end "{'success': 'http://#{req.headers['host']}/view?id=#{basename(path)}'}"
  else
    return res.end 'This API only accepts files!'
formidable = require 'formidable'
addImage = require '../src/addImage'
{basename} = require 'path'

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
      return res.end "{'error': 'Invalid file'}" if mime.indexOf('image/') isnt 0
      opt =
        path: path
        ip: req.connection.remoteAddress
        filter: filter
        title: title

      addImage config, opt, (err, path) ->
        return res.end err if err?
        return res.end "{'success': 'http://#{req.headers['host']}/view?id=#{basename(path)}'}"
  else
    return res.end 'Invalid method'
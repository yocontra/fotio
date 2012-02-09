{IncomingMessage, ServerResponse} = require 'http'

ServerResponse::deny = (errCode, msg) ->
  @statusCode = errCode or 403
  @end msg
  
IncomingMessage::mime = -> (@headers['content-type'] or '').split(';')[0]

module.exports = {}

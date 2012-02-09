slate = require 'slate'
{join} = require 'path'

process.argv = process.argv[2..]
[folder, port] = process.argv
throw 'Missing folder parameter' unless folder?
folder = join process.cwd(), folder
port ?= 8080

server = slate.create()
server.root folder
server.enable '404', 'mime', 'static'
server.listen port

console.log "Slate serving #{folder} on port #{port}"

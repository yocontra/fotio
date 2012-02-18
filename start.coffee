{join} = require 'path'
buildIndex = require './src/buildIndex'
buildFolders = require './src/buildFolders'
slate = require 'slate'
hogan = require 'slate-hogan'
redis = require 'redis'
redback = require 'redback'
filters = require './src/manipulator'

log = require 'node-log'
log.setName 'fotio'

server = slate.create()
server.root join __dirname, './public'
server.engine 'mustache', hogan, { title: "Fot.io", filters: Object.keys filters }
server.enable '404', 'api', 'static'

server.set 'fileLimit', 10 * 1024 * 1024 # 10mb file size limit
server.set 'tempDir', join __dirname, './tmp/'
server.set 'imageDir', join __dirname, './public/uploads/'
server.set 'images', redback.use(redis.createClient()).createHash 'images'
server.set 'demoImage', join __dirname, "./public/demo/demo"
server.set 'demoStore', join __dirname, "./public/demo/"
server.set 'production'

log.info "Building demo images..."
buildIndex server.config, (err) ->
  log.info "Setting up folders..."
  buildFolders server.config
  server.listen 8080
  log.info 'Fotio listening!'
{EventEmitter} = require 'events'
http = require 'http'
https = require 'https'
{readdirSync} = require 'fs'
{basename, extname, join} = require 'path'
{parse} = require 'url'
{lookupFile} = require './util'
require './httpExtend'

class HttpServer extends EventEmitter
  constructor: (@config) ->
    @loadDefaults()
    @on 'request', (req, res) =>
      stack = Array config.middle...
      next = =>
        ware = stack.shift()
        return unless ware? # no more middleware
        return next() unless ware.fn # invalid middleware
        ware.fn req, res, next, @config
      return next()

  engine: (ext, obj, data, options) -> @config.engines[ext] = compile: obj, data: data, options: options
  mime: (ext, type) -> @config.mime[ext] = type
  enable: (args...) -> @config.middle.push @config.defaultMiddle[name] for name in args when @config.defaultMiddle[name]?
  use: (name, fn, args...) -> @config.middle.push name: name, fn: fn, args: args

  listen: (@port, @host) ->
    if @config.get 'https'
      @server = https.createServer @handleRequest
    else
      @server = http.createServer @handleRequest
    @server.listen @port, @host
    @emit 'ready'
    return @server

  close: -> @server?.close()

  handleRequest: (req, res) =>
    return unless req? and res?
    pathname = parse(req.url).pathname
    file = lookupFile pathname, @config
    if file?
      req.resolvedPath = file.path
      req.isModule = file.isModule
    @emit 'request', req, res

  loadDefaults: ->
    middleDir = join __dirname + '/middle/'
    incl = readdirSync middleDir
    for file in incl
      absolute = join middleDir, file
      if require.resolve absolute
        name = basename(file, extname(file))
        @config.defaultMiddle[name] = name: name, fn: require(absolute), args: null

module.exports = HttpServer

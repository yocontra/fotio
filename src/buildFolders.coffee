{mkdirSync} = require 'fs'
{existsSync} = require 'path'

module.exports = (config) ->
  {tempDir, imageDir} = config
  mkdirSync tempDir unless existsSync tempDir
  mkdirSync imageDir unless existsSync imageDir
  return
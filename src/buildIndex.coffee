manipulator = require '../src/manipulator'
{join} = require 'path'
async = require 'async'

module.exports = (config, cb) ->
  demoImage = config.get 'demoImage'
  demoStore = config.get 'demoStore'
  processImage = (filter, call) ->
    manipulator[filter] demoImage, join(demoStore, "#{filter}.png"), call

  async.forEach Object.keys(manipulator), processImage, cb
  return
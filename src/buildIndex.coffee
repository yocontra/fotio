manipulator = require '../src/manipulator'
{join} = require 'path'
async = require 'async'

module.exports = (config, cb) ->
  demoImage = config.get 'demoImage'
  demoStore = config.get 'demoStore'
  fns = []
  for filter, transform of manipulator
    fns.push (callback) ->
      transform demoImage, join(demoStore, "#{filter}.png"), (err) -> callback err
  async.waterfall fns, cb
  return
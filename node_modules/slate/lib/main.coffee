Slate = require './Slate'
    
module.exports =
  version: -> require(__dirname + '../package.json').version
  create: (args...) -> return new Slate args...

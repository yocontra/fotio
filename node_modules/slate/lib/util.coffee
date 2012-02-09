{join, existsSync, readdirSync, dirname, basename, extname} = require 'path'

isFolder = (path) ->
  return unless path?
  lastChar = path.charAt path.length - 1
  return (lastChar is '/') or (lastChar is '\\')
  
module.exports =  
  lookupFile: (lpath, config) ->
    root = config.get 'root'
    engines = config.get 'engines'
    lpath = join root, lpath
    return unless lpath?
    
    # Find folder index
    if isFolder lpath
      path = join lpath, 'index.html'
      return path: path if existsSync path
      path = join lpath, 'index.htm'
      return path: path if existsSync path
      
      # Check custom engines
      for key in Object.keys engines
        path = join lpath, 'index.' + key
        return path: path if existsSync path
    else # Specific file
      return path: lpath if existsSync lpath
      try # node modules
        path = require.resolve lpath
        return path: path, isModule: true if path?
      catch err
        # do nothing - not a module
    return

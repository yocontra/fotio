gm = require 'gm'

getImage = (path) -> gm(path).autoOrient().antialias(false).noProfile()

module.exports =
  sepia: (path, npath, cb) -> getImage(path).sepia().write npath, (err) -> cb(err, npath)
  charcoal: (path, npath, cb) -> getImage(path).charcoal(1).write npath, (err) -> cb(err, npath)
  contrast: (path, npath, cb) -> getImage(path).contrast(3).write npath, (err) -> cb(err, npath)
  monochrome: (path, npath, cb) -> getImage(path).monochrome().write npath, (err) -> cb(err, npath)
  paint: (path, npath, cb) -> getImage(path).paint(2).write npath, (err) -> cb(err, npath)
  colors: (path, npath, cb) -> getImage(path).despeckle().write npath, (err) -> cb(err, npath)
  colors: (path, npath, cb) -> getImage(path).colors().write npath, (err) -> cb(err, npath)
  dither: (path, npath, cb) -> getImage(path).colors().dither(true).write npath, (err) -> cb(err, npath)
  edge: (path, npath, cb) -> getImage(path).edge().write npath, (err) -> cb(err, npath)
  emboss: (path, npath, cb) -> getImage(path).emboss(2).write npath, (err) -> cb(err, npath)
  enhance: (path, npath, cb) -> getImage(path).enhance().write npath, (err) -> cb(err, npath)
  equalize: (path, npath, cb) -> getImage(path).equalize().write npath, (err) -> cb(err, npath)
  flip: (path, npath, cb) -> getImage(path).flip().write npath, (err) -> cb(err, npath)
  flop: (path, npath, cb) -> getImage(path).flop().write npath, (err) -> cb(err, npath)

  hipster: (path, npath, cb) -> getImage(path).gamma(1.7, 2.3, 1.3).write npath, (err) -> cb(err, npath)
  hipster2: (path, npath, cb) -> getImage(path).modulate(100, 35, 100).colors().gamma(1.7, 2.3, 1.3).write npath, (err) -> cb(err, npath)
  hipster3: (path, npath, cb) -> getImage(path).modulate(20, 70, 100).contrast(0.8).write npath, (err) -> cb(err, npath)

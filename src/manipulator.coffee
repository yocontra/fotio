# env OMP_NUM_THREADS=2 /usr/local/bin/gm
gm = require 'gm'

getImage = (path) -> gm(path).autoOrient().antialias(false).noProfile()

module.exports =
  sepia: (path, npath, cb) -> getImage(path).sepia().write npath, cb
  charcoal: (path, npath, cb) -> getImage(path).charcoal(1).write npath, cb
  contrast: (path, npath, cb) -> getImage(path).contrast(3).write npath, cb
  monochrome: (path, npath, cb) -> getImage(path).monochrome().write npath, cb
  paint: (path, npath, cb) -> getImage(path).paint(2).write npath, cb
  colors: (path, npath, cb) -> getImage(path).despeckle().write npath, cb
  colors: (path, npath, cb) -> getImage(path).colors().write npath, cb
  dither: (path, npath, cb) -> getImage(path).colors().dither(true).write npath, cb
  edge: (path, npath, cb) -> getImage(path).edge().write npath, cb
  emboss: (path, npath, cb) -> getImage(path).emboss(2).write npath, cb
  enhance: (path, npath, cb) -> getImage(path).enhance().write npath, cb
  equalize: (path, npath, cb) -> getImage(path).equalize().write npath, cb
  flip: (path, npath, cb) -> getImage(path).flip().write npath, cb
  flop: (path, npath, cb) -> getImage(path).flop().write npath, cb

  hipster: (path, npath, cb) -> getImage(path).gamma(1.7, 2.3, 1.3).write npath, cb
  hipster2: (path, npath, cb) -> getImage(path).modulate(100, 35, 100).colors().gamma(1.7, 2.3, 1.3).write npath, cb
  hipster3: (path, npath, cb) -> getImage(path).modulate(20, 70, 100).contrast(0.8).write npath, cb

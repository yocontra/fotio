## Information

<table>
<tr> 
<td>Package</td><td>slate</td>
</tr>
<tr>
<td>Description</td>
<td>Barebones server with extensible middleware.</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.4</td>
</tr>
</table>

## Usage

```coffee-script
slate = require 'slate'
jade = require 'jade'

server = slate.create()

server.root "#{__dirname}/public"
server.enable 'csrf', 'lfi', 'xss', '404', 'mime', 'static'
server.engine 'jade', jade, {cool: 'params'}
server.set 'production'

server.listen 8080
console.log "Server started!"

server.route '/', (socket) ->
  console.log "Client connected"
  socket.on 'close', -> console.log "Client disconnected"
  socket.on 'message', (message) -> 
    socket.send 'ay yo waz gud wurld'
    
server.route '/hello', (socket) ->
  socket.on 'message', (message) -> 
    socket.send 'hello world!'
```

## Examples

You can view further examples in the [example folder.](https://github.com/wearefractal/slate/tree/master/examples)

## LICENSE

(MIT License)

Copyright (c) 2012 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

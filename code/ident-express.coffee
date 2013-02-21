net = require 'net'

checkIdent = (req, resp, next) ->
  # If available, the nginx x-real-port, x-server-port, x-real-ip
  # headers are used.
  remotePort = req.headers['x-real-port'] or req.connection.remotePort
  localPort = req.headers['x-server-port'] or port

  # See RFC 1413 http://www.ietf.org/rfc/rfc1413.txt
  socket = net.connect
    port: 113
    host: req.headers['x-real-ip'] or req.connection.remoteAddress
  , ->
    socket.write "#{remotePort},#{localPort}\r\n"
  data = ''
  socket.on 'error', (err) ->
    next()
  socket.on 'data', (buffer) ->
    data += buffer.toString()
  socket.on 'end', ->
    box = data.split(':')[3]
    if box?
      req.ident = box.trim()
    next()

module.exports = checkIdent

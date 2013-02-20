# Ident Express

Adds ident authentation to your express.js routes.

How to use (in CoffeeScript):

    checkIdent = require 'ident-express'
    app.get '/foo', checkIdent, (req, res) ->
      # Do something with req.ident
      console.log "I think you are " + req.ident

## Ident

Ident is described in [RFC 1413](http://www.ietf.org/rfc/rfc1413.txt).
One important thing to note is that the information returned by
identd should only be trusted if you trust the machine running
the identd, which is the machine from which the connection has
been made (the user/browser/service that is making the
GET/POST/PUT request).

## nginx

If your express.js app is behind a reverse-proxy such as nginx
then the IP address that express.js sees will be those of nginx,
not of the original HTTP request that was made to nginx.  nginx
can set headers that reveal the real IP address.  Ident express
will make use of the headers `X-Real-Port`, `X-Real-IP`, `X-Server-Port`
which can be set by using the following fragment of nginx config:

    proxy_set_header X-Real-Port $remote_port;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Server-IP $server_addr;
    proxy_set_header X-Server-Port $server_port;


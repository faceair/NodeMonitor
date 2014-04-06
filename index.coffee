Monitor = require("./Monitor")
express = require('express')
app = express()
http = require('http')
server = http.createServer(app)
io = require('socket.io').listen(server)

server.listen(3000);

app.get "/", (req, res) ->
  res.sendfile __dirname + "/index.html"
  return

io.sockets.on "connection", (socket) ->
  Monitor.memData socket
  setInterval(Monitor.osData, 1000)
  setInterval(Monitor.memData, 5000)

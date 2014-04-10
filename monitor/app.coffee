handler = (req, res) ->
  reqfile = url.parse(req.url).pathname.slice(1).match(/[a-zA-Z0-9_ -.]+/) ? "index.html"
  fs.readFile "../static/" + reqfile, (err, data) ->
    if err
      res.writeHead 500
      return res.end("Error loading " + reqfile)
    res.writeHead 200
    res.end(data);

Monitor = require("./Monitor")
url = require('url')
app = require("http").createServer(handler)
io = require("socket.io").listen(app)
fs = require("fs")
app.listen 3000

io.sockets.on "connection", (socket) ->
  setInterval(Monitor.osData, 1000, socket)
  setInterval(Monitor.memData, 5000, socket)
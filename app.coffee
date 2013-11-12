express = require "express"
routes  = require "./routes"
http    = require "http"
path    = require "path"

# CONFIGURATION
app = express()

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use require("stylus").middleware(__dirname + "/public")
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

# URLS
app.get "/", routes.index

# RUN SERVER
server = http.createServer(app)
sio    = require('socket.io').listen(server)
sio.set('log level', 1);

server.listen app.get("port"), ->
  console.log ("Express server listening on port " + app.get("port"))

# GAME and SOCKET.IO
require('./routes/socket')(app, sio)


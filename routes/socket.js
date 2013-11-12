// Generated by CoffeeScript 1.6.1
(function() {

  eval(require('fs').readFileSync('./public/jgo/jgoboard.js', 'utf8'));

  module.exports = function(app, sio) {
    var BOARD;
    BOARD = new JGOBoard(19);
    BOARD.clear();
    return sio.sockets.on('connection', function(socket) {
      console.log('A socket connected.');
      socket.on('move', function(data) {
        BOARD.fromString(data.board);
        return sio.sockets.emit('update', {
          'board': BOARD.toString()
        });
      });
      socket.on('full', function() {
        return socket.emit('update', {
          'board': BOARD.toString()
        });
      });
      return socket.on('disconnect', function() {
        return console.log('A socket disconnected.');
      });
    });
  };

}).call(this);

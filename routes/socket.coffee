eval(require('fs').readFileSync('./public/jgo/jgoboard.js', 'utf8'))

module.exports = (app, sio)->

	BOARD = new JGOBoard(19)
	BOARD.clear()

	sio.sockets.on 'connection', (socket)->
		console.log('A socket connected.')

		socket.on 'move', (data)->
			#console.log 'RECEIVED'
			BOARD.fromString data.board
			sio.sockets.emit 'update', {'board' : BOARD.toString()}

		socket.on 'full', () ->
			socket.emit 'update', {'board' : BOARD.toString()}
			
		socket.on 'disconnect', ->
			console.log('A socket disconnected.')
			

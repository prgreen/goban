$ = jQuery
PLAYER_COLOR = JGO_BLACK

$ ->

	$('#black').click(()->
		PLAYER_COLOR = JGO_BLACK
		console.log 'BLACK')
	
	$('#white').click(()->
		PLAYER_COLOR = JGO_WHITE
		console.log 'WHITE')

	board = jgo_generateBoard($("#board"))
		
	socket = io.connect("")

	socket.on 'connect', ->
		
		socket.emit 'full'

		board.click = (coord) ->
			if board.get(coord) == JGO_CLEAR and PLAYER_COLOR != null
				board.play(coord, PLAYER_COLOR)
				socket.emit('move', {'board' : board.toString()})

		$('#clear').click(()->
			board.clear()
			socket.emit('move', {'board' : board.toString()}))

		socket.on 'update', (data) ->
			console.log 'UPDATE'
			board.fromString(data.board)


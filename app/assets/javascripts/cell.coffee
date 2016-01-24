define [
  'cell',
],

(Cell, Board) ->
  class Cell

    constructor: (@row, @col) ->
      @id = "cell_#{@row}_#{@col}"

    isEmpty: ->
      not @playerId?

    setPlayer: (id) ->
      @playerId = id

    getPlayer: ->
      @playerId

    getColor: ->
      if @playerId == 0 then 'blue' else 'yellow'

    idSplit: ->
      @id.split('_')

    idJoin: (row, col) ->
      "cell_#{row}_#{col}"

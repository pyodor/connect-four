define [
  'cell'
],

(Cell) ->
  class Cell

    constructor: (@row, @col) ->
      @id = "cell_#{@row}_#{@col}"

    isEmpty: ->
      not @player_id?

    setPlayer: (id) ->
      @player_id = id

    getPlayer: ->
      @player_id

    getColor: ->
      if @player_id == 0 then 'blue' else 'yellow'

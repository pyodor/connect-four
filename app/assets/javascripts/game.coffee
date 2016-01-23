define [
  'jquery'
  'board',
  'game'
],

($, Board, Game) ->
  class Game

    constructor: (@board) ->
      Game.board = @board
      Game.current_player = 0
      td = @board.table.find "td"
      td.on "click", ->
        Game.check @

    @check: (cell) ->
      @current_cell = cell
      @win_check() if @valid_drop()

    @win_check: ->
      console.log "todo win check"

    @valid_drop: ->
      @current_cell_id = $(@current_cell).attr("id")
      [tag, row, col] = @current_cell_id.split("_")
      below_cell_id = "#{tag}_#{parseInt(row)+1}_#{col}"
      @below_cell = @board.findCell(below_cell_id)

      @success_drop = false
      @mark cell for cell in @board.cells
      return @success_drop

    @mark: (cell) ->
      marked = false
      if not @below_cell? # this must be bottom row
        with_below_cell = true
      else
        with_below_cell = not @below_cell.isEmpty()

      if @current_cell_id == cell.id and cell.isEmpty() and with_below_cell
        cell.setPlayer @current_player
        @current_player = if cell.getPlayer() == 1 then 0 else 1
        @board.setCellColor(@current_cell_id)
        @success_drop =  true

define [
  'jquery'
  'board',
  'game'
],

($, Board, Game) ->
  class Game

    constructor: (@board) ->
      Game.currentPlayer = 0
      @start()
      window.ConnectFour = @

    start: ->
      Game.board = @board
      Game.connectedCells = 0
      @board.currentMove(Game.currentPlayer)
      td = @board.table.find "td"
      td.on "click", ->
        Game.check @

    @check: (cell) ->
      currentCellId = $(cell).attr 'id'
      @currentCell = @board.findCell currentCellId
      @winCheck() if @validDrop()

    @winCheck: ->
      win = false
      win = switch true
        when @yWin() then true
        when @xWin() then true
        when @diagonalLeftWin() then true
        when @diagonalRightWin() then true

      if win
        @board.notifyWinner(@currentPlayer)
      else
        @currentPlayer = if @currentCell.getPlayer() == 1 then 0 else 1
        @board.currentMove(@currentPlayer)

    @connectFour: (cellId) ->
      nextCell = @board.findCell cellId

      if nextCell and nextCell.getPlayer() == @currentCell.getPlayer()
        @connectedCells += 1
      else
        @connectedCells = 0

      return if @connectedCells == 4 then true else false

    @xWin: ->
      @connectedCells = 0
      [..., row, col] = @currentCell.idSplit()
      for x in [0..@board.numCols]
        nextCellId = @currentCell.idJoin row, x
        return true if @connectFour nextCellId

    @yWin: ->
      @connectedCells = 0
      [..., row, col] = @currentCell.idSplit()
      for y in [0..@board.numRows]
        nextCellId = @currentCell.idJoin y, col
        return true if @connectFour nextCellId

    @diagonalLeftWin: ->
      @connectedCells = 0
      [..., row, col] = @currentCell.idSplit()

      # scan diagonal ( \ ) get the origin
      done = false
      y = parseInt(row)
      x = parseInt(col)
      until done
        y -= 1
        x -= 1
        done = true if y == 0 or x == 0

      # if valid origin loop diagonally 'till the end
      # looking for a win
      if x >= 0 or y >= 0
        done = false
        win = false
        until done
          nextCellId = @currentCell.idJoin y, x
          y += 1
          x += 1
          if @connectFour nextCellId
            win = true
            done = true

          done = true if y == @board.numRows or x == @board.numCols

        return win


    @diagonalRightWin: ->
      @connectedCells = 0
      [..., row, col] = @currentCell.idSplit()

      # scan diagonal ( / ) get the origin
      done = false
      y = parseInt(row)
      x = parseInt(col)
      until done
        y -= 1
        x += 1
        done = true if y == 0 or x == @board.numCols - 1

      # if valid origin loop diagonally 'till the end
      # looking for a win
      if x >= 0 and x < @board.numCols or y >= 0
        done = false
        win = false
        until done
          nextCellId = @currentCell.idJoin y, x
          y += 1
          x -= 1
          if @connectFour nextCellId
            win = true
            done = true

          done = true if y == @board.numRows or x == 0

        return win

    @validDrop: ->
      [..., row, col] = @currentCell.idSplit()
      belowRow = parseInt(row) + 1
      belowCellId = @currentCell.idJoin(belowRow, col)
      @belowCell = @board.findCell(belowCellId)

      @successDrop = false
      @mark cell for cell in @board.cells
      return @successDrop

    @mark: (cell) ->
      marked = false
      if not @belowCell? # this must be bottom row
        withBelowCell = true
      else
        withBelowCell = not @belowCell.isEmpty()

      if @currentCell.id == cell.id and cell.isEmpty() and withBelowCell
        cell.setPlayer @currentPlayer
        @board.setCellColor(@currentCell.id)
        @successDrop =  true

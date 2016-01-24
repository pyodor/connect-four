define [
  'jquery'
  'cell'
  'board'
  'game'
],

($, Cell, Board, Game) ->
  class Board
    constructor: (@table, @numRows, @numCols) ->
      @init()

    init: ->
      @cells = []
      @table.html ""
      tRow = ""
      for row in [0...@numRows]
        tCol = ""
        for col in [0...@numCols]
          cell = new Cell row, col
          @cells.push cell
          tCol += "<td id='#{cell.id}' class='circle'><img/></td>"

        @table.append("<tr>#{tCol}</tr>")

    findCell: (cellId) ->
      cell = $.grep @cells, (cell) ->
        return cell.id == cellId
      return cell[0]

    notifyWinner: (player) ->
      setTimeout () ->
        color = Board.playerColor(player)
        playerName = color.charAt(0).toUpperCase() + color.slice 1
        alert "#{playerName} win!"
        window.ConnectFour.board.init()
        window.ConnectFour.start();
      , 100


    currentMove: (player) ->
      $(".board .current-move img").css {'background-color': Board.playerColor(player)}

    setCellColor: (cellId) ->
      cell = @findCell(cellId)
      $("##{cellId}").css {'background-color': cell.getColor()}

    @playerColor: (player) ->
      if player == 0 then 'blue' else 'yellow'

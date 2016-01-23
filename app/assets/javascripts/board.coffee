define [
  'jquery'
  'cell'
  'board'
],

($, Cell, Board) ->
  class Board
    cells: []

    constructor: (@table, @num_rows, @num_cols) ->
      t_row = ""
      for row in [0...@num_rows]
        t_col = ""
        for col in [0...@num_cols]
          cell = new Cell row, col
          @cells.push cell
          t_col += "<td id='#{cell.id}'><img/></td>"

        @table.append("<tr>#{t_col}</tr>")

    findCell: (cell_id) ->
      cell = $.grep @cells, (cell) ->
        return cell.id == cell_id
      return cell[0]

    setCellColor: (cell_id) ->
      cell = @findCell(cell_id)
      $("##{cell_id}").css {'background-color': cell.getColor()}

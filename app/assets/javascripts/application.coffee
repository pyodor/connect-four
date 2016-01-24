require [
  'jquery',
  'board',
  'game'
],

($, Board, Game) ->
  $ ->
    board = new Board $(".board table"), 6, 7
    new Game board

    setTimeout () ->
      alert "Players ready?"
    , 100

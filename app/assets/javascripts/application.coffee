require [
  'jquery',
  'board',
  'game'
],

($, Board, Game) ->
  $ ->
    board = new Board $(".board table"), 6, 7
    window.Game = new Game board

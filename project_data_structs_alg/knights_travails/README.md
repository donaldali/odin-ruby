# Knight's Travails

A knight in chess can move from any square of a chess board to any other square.  This script finds a shortest path (number of moves) a knight can take between any two squares of a chess board using Breath First Search.

The squares of the 8 X 8 chess board are represented as 2-dimensional coordinates each with values from 0 - 7, so `[0, 7]` is a valid square but `[8, 4]` is not.

`#knight_moves` calculates and displays the moves of a shortest path between any two squares.
First, in irb, `require './knights_travails'`, then provide the `#knight_moves` method with any two valid chess board squares (eg `knight_moves([0, 0], [7, 7])`).

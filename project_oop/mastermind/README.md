# Mastermind

Welcome to a CLI implementation of Mastermind. Mastermind is a code-breaking game between two players.  Please see the <a href="http://en.wikipedia.org/wiki/Mastermind_(board_game)">Wikipedia article on Mastermind</a> if you are unfamiliar with the game.

To play this game, enter `$ rake` from the root directory (mastermind).

+ **Note**: Windows users should install the `win32console` gem to get the colors required to play this game.

### Color Code Format

Your interaction with the game will mainly consist of you inputing a code of colors (either making a code as codemaker or guessing a code as codebreaker). A code consists of 4 colors out of 6 possible colors (Red, Green, Yellow, Blue, Magenta, and Cyan). ** _Colors can be repeated in a code._ **  You may enter a color by it's full name or first letter, case insensitive.  Enter a code as a comma or space separated list of 4 colors.  All the following are valid ways to enter the code of colors Red Green Blue Yellow:

+ `red green blue yellow`
+ `red, green, blue, yellow`
+ `red,green,blue,yellow`
+ `r g b y`
+ `r, g, b, y`
+ `r,g,b,y`
+ `rgby` (my prefered method)

### Game Setup

In this game, you will be playing against a randomly selected famous AI (like `HAL 9000` or `Skynet`). Each game consists of at most 10 rounds (you choose the number of rounds) with each round consisting of you as codemaker and codebreaker (you choose which you will be first).

### Game Board

The main board is divided into 3 boards: a guessing board (on the left), a rating board (on the right) and a secret board (on the bottom).  The main board, and some game setup, at the start of the game is shown below:

```
A round consists of two passes; once with you as codemaker
and once with you as codebreaker.
Enter number of rounds (1-10): 3
Enter your initial role, codemaker or codebreaker (M/B): m

Round 1. Donald is the codemaker; HAL 9000 is the codebreaker.

Colors:   Red    Green    Yellow    Blue    Magenta    Cyan  
Choose a color with it's full name or it's first character
	╔═══╦═══╦═══╦═══╗ ╔══╦══╦══╦══╗
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╠═══╬═══╬═══╬═══╣ ╠══╬══╬══╬══╣
	║   ║   ║   ║   ║ ║  ║  ║  ║  ║
	╚═══╩═══╩═══╩═══╝ ╚══╩══╩══╩══╝
	╔═══╦═══╦═══╦═══╗
	║   ║   ║   ║   ║
	╚═══╩═══╩═══╩═══╝
Enter your secret code as a comma-separated list of 4 colors.
Enter Code: 
```

Colors will be displayed above the board and in the board squares (top to bottom).

### Game Play

You have 12 guesses to crack a code, but the fewer guesses you make the lower score your opponent gets. (You win by getting the secret code(s) in fewer guesses than your opponent).

After you make a guess, your colors are displayed on the guessing board, and some feedback is given on the rating board as a number of black and/or white squares.  Each black square means you have correctly guessed a color in it's right place in the secret code; each white square means you have correctly guessed a color but in the wrong place in the secret code.  For example, a guess of `r,g,b,y` for the secret code `r,r,y,g` will yield one black square (for `r`) and two white squares (for `g` and `y`).
** _Recall that a color may be repeated in a code._ **

+ *__Recommendation__: Adjust the background of your Terminal so you can see both black and white (you probably don't want a solid black or solid white background; something in between should be fine)*.

### AI Algorithm

The AI that this game uses is based on <a href="http://en.wikipedia.org/wiki/Mastermind_(board_game)#Algorithms">Donald Knuth's Five-guess algorithm</a>. However due to the computationally expensive sixth step of the algorithm, this AI randomly selects a possible code after the fifth step. (The performance of this AI is still close to that of the full Five-guess algorithm).

##### *Enjoy the game*

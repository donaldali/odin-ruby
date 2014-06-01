# Hangman

A CLI implementation of Hangman. If you are unfamiliar with Hangman, please see the <a href="http://en.wikipedia.org/wiki/Hangman_(game)">Wikipedia article on Hangman</a>.

Run this game with `$ rake` from the root directory (hangman).

### Game Features

This game provides the ability to save a game in progress and continue it later. You can also manage previously saved games. The main game menu is shown below:

```
Hangman Options
===============
1. Play Hangman
2. Load Saved Game
3. Delete Saved Game
4. List Saved Games
5. Quit
Enter Selection (1 - 5): 
```

### Game Play

You have 10 incorrect guesses to get the secret word (which is selected at random from the [5desk.txt dictionary](http://scrapmaker.com/view/twelve-dicts/5desk.txt).) Follow in game instructions and enjoy the game. A sample game in progress is shown below:

```
 ┏━━┑ 	Word            : TE__I_I_
 ┃  ⵔ 	Misses          : A,H,P,O,U
 ┃    	Correct guesses : E,T,I
 ┃    	Guesses left    : 5
━┻━━━━	Enter next guess ('save' to save game): 
```
# TDD Connect Four

A CLI implementation of [Connect Four](http://en.wikipedia.org/wiki/Connect_Four), written following [Test-Driven Development](http://en.wikipedia.org/wiki/Test-driven_development) (TDD).

Run `rake spec` from the root directory	(connect_four_tdd) to run the RSpec tests; to play the game, run `rake` from the same root directory.

Stubs, mocks, and helper methods are used together with direct testing of various methods to extensively test the game, including testing for each winning configuration.

Play the game by playing pieces in the numbered columns as directed in the game (as shown below):

```
	*************************************
	*****  Welcome to Connect Four  *****
	*************************************

Choose column to place a piece by the numbers below
	 1    2    3    4    5    6    7
	 ⬇   ⬇    ⬇    ⬇   ⬇    ⬇   ⬇  
	 ⬤   ⬤   ⬤   ⬤   ⬤   ⬤   ⬤  
	                            
	 ⬤   ⬤   ⬤   ⬤   ⬤   ⬤   ⬤  
	                            
	 ⬤   ⬤   ⬤   ⬤   ⬤   ⬤   ⬤  
	                            
	 ⬤   ⬤   ⬤   ⬤   ⬤   ⬤   ⬤  
	                            
	 ⬤   ⬤   ⬤   ⬤   ⬤   ⬤   ⬤  
	                            
	 ⬤   ⬤   ⬤   ⬤   ⬤   ⬤   ⬤  
	                            
Red player, Enter column to play in (1-7): 
```

In game display will be colored and so Windows users will need to `gem install win32console` to get the colored display.

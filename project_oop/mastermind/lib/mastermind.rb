#!/usr/bin/env ruby

require './lib/mastermind/mastermind_module.rb'
require './lib/mastermind/board.rb'
require './lib/mastermind/player.rb'
require './lib/mastermind/player_ai.rb'
require './lib/mastermind/mastermind_game.rb'
include Mastermind

mastermind_game = MastermindGame.new
mastermind_game.play

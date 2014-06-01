#!/usr/bin/env ruby

require './lib/hangman_game'
require './lib/hangman_view'
require 'yaml'

hangman_game = HangmanGame.new
hangman_game.play

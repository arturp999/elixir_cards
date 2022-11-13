defmodule ElixirCardsTest do
  use ExUnit.Case
  doctest ElixirCards

  test "create_deck makes 20 cards" do
    deck_length = length(ElixirCards.test(false))
    assert deck_length == 20
  end

  test "shuffling a deck randomize" do
    deck = ElixirCards.test(false)
    refute deck == ElixirCards.shuffle(deck)
  end
end

defmodule ElixirCards do
  # DOCUMENTATION USING ex_doc, after we need to run mix docs to generate html with the documentation
  @moduledoc """
    Provides methods to create and handle a deck of cardsv
  """

  @doc """
    Two options create deck with a list flatten or the proper way
  """
  # not sure how to create constant yet so..
  def test(boolFlatten) do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    if boolFlatten do
      # THIS WORKS BUT ITS NOT THE CORRECT WAY TO DO IT
      create_deck_with_list_flatten(values, suits)
    else
      # CORRECT WAY TO DO IT
      create_deck(values, suits)
    end
  end

  def create_deck_with_list_flatten(values, suits) do
    # List comprehension(its a mapping function)
    # will return ex:
    # [
    # ["Ace of Spaces", "Ace of Clubes"..],
    # ["Two of Spaces", "Two of Clubes"..],
    # ....
    # ]
    cards =
      for value <- values do
        for suit <- suits do
          "#{value} of #{suit}"
        end
      end

    # Will put all the lists together ex ["Ace of Spaces", "Ace of Clubes".."Two of Spaces", "Two of Clubes"..]
    List.flatten(cards)
  end

  def create_deck(values, suits) do
    for suit <- suits, value <- values do
      # Will return ["Ace of Spaces", "Ace of Clubes".."Two of Spaces", "Two of Clubes"..]
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Verify if card is inside provided deck
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    will devide de the deck by the `handsize`
  """
  def deal(deck, hand_size) do
    # will return a tuple {[deck],[hand_size]}
    Enum.split(deck, hand_size)
  end

  # SAVING AND LOADING TO SYSTEM
  def save(deck, filename) do
    # envoking erlang turning into a binary object
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    #  {status, binary} = File.read(filename) #Pattern matching
    # inspecting the status value, if ok 1st line (will return list of cards) else custom error
    case File.read(filename) do
      # Pattern matching result with conditions
      # If the result of file.read is a tuple with :ok and the 2nd value is a varieble
      {:ok, binary} -> :erlang.binary_to_term(binary)
      # _reason says its there for pattern matching
      {:error, _reason} -> "That file does not exist"
    end
  end

  # PIPE OPERATOR, examples will run when using tests (mix test)
  @doc """
      ## Examples
      iex(1)>  {hand,_deck} = ElixirCards.create_hand(1)
      iex(1)>  hand
      ["Ace of Spades"]
  """
  def create_hand(hand_size) do
    ElixirCards.test(false)
    # |> ElixirCards.shuffle()
    |> ElixirCards.deal(hand_size)
  end
end

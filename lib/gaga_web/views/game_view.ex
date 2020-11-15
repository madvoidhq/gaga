defmodule GagaWeb.GameView do
  use GagaWeb, :view

  def deck do
    ~W(0 1 2 3 5 8 13 20 40 100 ??? ☕️)
  end

  def votes_count(votes) do
    Enum.count(votes)
  end

  def vote_class(nil), do: "red"
  def vote_class(_), do: "green"

  def display_votes?(assigns) do
    assigns.cards_flipped? || assigns.everyone_voted?
  end

  @doc """
  Compute common stats like `min`, `max`, and `avg` from votes
  """
  def stats(votes) do
    votes
    |> extract_scores
    |> compute_stats
  end

  defp extract_scores(votes) do
    votes
    |> Stream.map(&score/1)
    |> Enum.reject(&is_nil/1)
  end

  # Parse votes and return integer score or `nil`
  defp score(vote) do
    case Integer.parse(vote) do
      :error ->
        nil

      {int, _} ->
        int
    end
  end

  # Return `[min:, max:, avg:]` from a list of integer scores
  defp compute_stats([]), do: [min: "?", max: "?", avg: "?"]

  defp compute_stats(scores) do
    reduce_fun = fn
      entry, :empty ->
        # min, max, sum, count
        {entry, entry, entry, 1}

      entry, {min, max, sum, count} ->
        {Kernel.min(min, entry), Kernel.max(max, entry), sum + entry, count + 1}
    end

    {min, max, sum, count} = Enum.reduce(scores, :empty, reduce_fun)

    [min: min, max: max, avg: Float.round(sum / count, 2)]
  end
end

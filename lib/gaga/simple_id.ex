defmodule Gaga.SimpleId do
  @alphabet "bcdfghjklmnpqrstvwxz" |> String.to_charlist()
  @length 10

  @doc """
  Generates a readable random ID
  """
  def new do
    1..@length
    |> Enum.map(fn _ -> Enum.random(@alphabet) end)
    |> to_string
    |> format
  end

  @doc """
  Pretty prints a SimpleId with format `xxx-xxxx-xxx`.
  Supports already formated id.
  """
  def format(<<s1::bytes-size(3), s2::bytes-size(4), s3::bytes-size(3)>>) do
    "#{s1}-#{s2}-#{s3}"
  end

  def format(<<_::bytes-size(3), ?-, _::bytes-size(4), ?-, _::bytes-size(3)>> = id), do: id
end

defmodule SecureRandom do
  @default_bytes 16

  def base64(bytes \\ @default_bytes) do
    random_bytes(bytes) |> Base.url_encode64(case: :lower)
  end

  def hex(bytes \\ @default_bytes) do
    random_bytes(bytes) |> Base.encode16(case: :lower)
  end

  def random_bytes(bytes \\ @default_bytes) do
    :crypto.strong_rand_bytes(bytes)
  end
end

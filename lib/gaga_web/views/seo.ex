defmodule GagaWeb.SEO do
  alias GagaWeb.Router.Helpers, as: Routes

  # The title of your object as it should appear within the graph, e.g., "The
  # Rock" (max: 65 chars).
  def title do
    "Gaga · Planning Poker for remote teams"
  end

  # A one to two sentence description of your object (max: 300 chars).
  def description do
    """
    Gaga is an online planning poker app built in Elixir, using Phoenix \
    and LiveView. It's free, open source, and doesn't require signing up.\
    """
  end

  # e.g., "en" or "fr".
  def lang do
    "en"
  end

  # e.g., "en_US" or "fr_FR".
  def locale do
    "en_US"
  end

  # If your object is part of a larger web site, the name which should be
  # displayed for the overall site. e.g., "IMDb".
  def site_name do
    "Gaga"
  end

  # An image URL which should represent your object within the graph.
  def image do
    static_image("/images/social-image.png")
  end

  # The type of your object, e.g., "video.movie". Depending on the type you
  # specify, other properties may also be required.
  #
  # see https://ogp.me/#types
  def type do
    "website"
  end

  def twitter_user do
    "@madvoid"
  end

  # The canonical URL of your object that will be used as its permanent ID in
  # the graph, e.g., "https://www.imdb.com/title/tt0117500/".
  def url do
    "#{System.get_env("ROOT_URL")}/"
  end

  defp static_image(path), do: Routes.static_url(GagaWeb.Endpoint, path)
end

defmodule CounterLiveApp.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CounterLiveApp.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        published: true,
        published_at: ~N[2024-07-21 11:49:00],
        title: "some title",
        views: 42
      })
      |> CounterLiveApp.Blog.create_post()

    post
  end
end

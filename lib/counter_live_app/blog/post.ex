defmodule CounterLiveApp.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :body, :string
    field :published_at, :naive_datetime
    field :published, :boolean, default: false
    field :views, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body, :published_at, :published, :views])
    |> validate_required([:title, :body, :published_at, :published, :views])
  end
end

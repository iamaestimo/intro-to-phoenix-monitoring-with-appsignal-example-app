defmodule CounterLiveApp.BlogTest do
  use CounterLiveApp.DataCase

  alias CounterLiveApp.Blog

  alias CounterLiveApp.Blog.Post

  @valid_attrs %{title: "some title", body: "some body", published_at: ~N[2024-07-21 11:49:00], published: true, views: 42}
  @update_attrs %{title: "some updated title", body: "some updated body", published_at: ~N[2024-07-22 11:49:00], published: false, views: 43}
  @invalid_attrs %{title: nil, body: nil, published_at: nil, published: nil, views: nil}

  describe "#paginate_posts/1" do
    test "returns paginated list of posts" do
      for _ <- 1..20 do
        post_fixture()
      end

      {:ok, %{posts: posts} = page} = Blog.paginate_posts(%{})

      assert length(posts) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end
  end

  describe "#list_posts/0" do
    test "returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end
  end

  describe "#get_post!/1" do
    test "returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end
  end

  describe "#create_post/1" do
    test "with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.title == "some title"
      assert post.body == "some body"
      assert post.published_at == ~N[2024-07-21 11:49:00]
      assert post.published == true
      assert post.views == 42
    end

    test "with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end
  end

  describe "#update_post/2" do
    test "with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Blog.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.title == "some updated title"
      assert post.body == "some updated body"
      assert post.published_at == ~N[2024-07-22 11:49:00]
      assert post.published == false
      assert post.views == 43
    end

    test "with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end
  end

  describe "#delete_post/1" do
    test "deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end
  end

  describe "#change_post/1" do
    test "returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end

  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Blog.create_post()

    post
  end

end

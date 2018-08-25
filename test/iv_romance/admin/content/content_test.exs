defmodule IvRomance.Admin.ContentTest do
  use IvRomance.DataCase

  alias IvRomance.Admin.Content

  describe "pages" do
    alias IvRomance.Content.Page

    @valid_attrs %{body: "some body", path: "/some/path", title: "some title"}
    @update_attrs %{
      body: "some updated body",
      path: "/some/updated-path",
      title: "some updated title"
    }
    @invalid_attrs %{body: nil, path: nil, title: nil}

    def page_fixture(attrs \\ %{}) do
      {:ok, page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_page()

      page
    end

    test "list_pages/0 returns all pages" do
      page = page_fixture()
      assert Content.list_pages() == [page]
    end

    test "get_page!/1 returns the page with given id" do
      page = page_fixture()
      assert Content.get_page!(page.id) == page
    end

    test "create_page/1 with valid data creates a page" do
      assert {:ok, %Page{} = page} = Content.create_page(@valid_attrs)
      assert page.body == "some body"
      assert page.path == "/some/path"
      assert page.title == "some title"
    end

    test "create_page/1 does not create page with invalid path" do
      assert {:error, %Ecto.Changeset{}} =
               Content.create_page(Map.put(@valid_attrs, :path, "no-slash"))

      assert {:error, %Ecto.Changeset{}} =
               Content.create_page(Map.put(@valid_attrs, :path, "/with spaces"))

      assert {:error, %Ecto.Changeset{}} = Content.create_page(Map.put(@valid_attrs, :path, ""))
    end

    test "create_page/1 does not create page with already taken path" do
      assert {:ok, %Page{} = page} = Content.create_page(@valid_attrs)
      assert {:error, %Ecto.Changeset{}} = Content.create_page(@valid_attrs)
    end

    test "create_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_page(@invalid_attrs)
    end

    test "update_page/2 with valid data updates the page" do
      page = page_fixture()
      assert {:ok, page} = Content.update_page(page, @update_attrs)
      assert %Page{} = page
      assert page.body == "some updated body"
      assert page.path == "/some/updated-path"
      assert page.title == "some updated title"
    end

    test "update_page/2 with invalid data returns error changeset" do
      page = page_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_page(page, @invalid_attrs)
      assert page == Content.get_page!(page.id)
    end

    test "delete_page/1 deletes the page" do
      page = page_fixture()
      assert {:ok, %Page{}} = Content.delete_page(page)
      assert_raise Ecto.NoResultsError, fn -> Content.get_page!(page.id) end
    end

    test "change_page/1 returns a page changeset" do
      page = page_fixture()
      assert %Ecto.Changeset{} = Content.change_page(page)
    end
  end
end

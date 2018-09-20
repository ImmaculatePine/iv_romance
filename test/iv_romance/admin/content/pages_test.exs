defmodule IvRomance.Admin.Content.PagesTest do
  use IvRomance.DataCase

  import IvRomance.Factory

  alias IvRomance.Admin.Content
  alias IvRomance.Content.Page
  alias Ecto.{Changeset, NoResultsError, UUID}

  describe "list_pages/0" do
    test "returns list of existing pages" do
      page = insert(:page)

      assert Content.list_pages() == [page]
    end
  end

  describe "get_page!/1" do
    test "returns the page with given id" do
      %{id: id} = page = insert(:page)

      assert Content.get_page!(id) == page
    end

    test "raises NoResultsError when page does not exist" do
      assert_raise NoResultsError, fn -> Content.get_page!(UUID.generate()) end
    end
  end

  describe "create_page/1" do
    test "creates a page with valid params" do
      %{path: path, title: title, body: body} = params = params_for(:page)
      assert {:ok, %Page{path: ^path, title: ^title, body: ^body}} = Content.create_page(params)
    end

    test "returns error changeset when title is blank" do
      assert {:error, %Changeset{} = changeset} =
               Content.create_page(params_for(:page, title: ""))

      assert %{errors: [title: {"can't be blank", [validation: :required]}]} = changeset
    end

    test "returns error changeset when body is blank" do
      assert {:error, %Changeset{} = changeset} = Content.create_page(params_for(:page, body: ""))
      assert %{errors: [body: {"can't be blank", [validation: :required]}]} = changeset
    end

    test "returns error changeset when path is blank" do
      assert {:error, %Changeset{} = changeset} = Content.create_page(params_for(:page, path: ""))
      assert %{errors: [path: {"can't be blank", [validation: :required]}]} = changeset
    end

    test "returns error changeset when path is in invalid format" do
      Enum.each(["no-slash", "/with spaces"], fn path ->
        assert {:error, %Changeset{} = changeset} =
                 Content.create_page(params_for(:page, path: path))

        assert %{errors: [path: {"has invalid format", [validation: :format]}]} = changeset
      end)
    end

    test "returns error changeset when path is already taken" do
      %{path: path} = insert(:page)

      assert {:error, %Changeset{} = changeset} =
               Content.create_page(params_for(:page, path: path))

      assert %{errors: [path: {"has already been taken", []}]} = changeset
    end
  end

  describe "update_page/2" do
    test "updates the page with valid data" do
      %{id: id} = page = insert(:page)
      %{path: path, title: title, body: body} = params = params_for(:page)

      assert {:ok, page} = Content.update_page(page, params)
      assert %Page{id: ^id, path: ^path, title: ^title, body: ^body} = page
    end

    test "returns errors changeset with invalid data" do
      %{id: id} = page = insert(:page)

      assert {:error, %Changeset{}} = Content.update_page(page, %{path: ""})
      assert page == Content.get_page!(id)
    end
  end

  describe "delete_page/1" do
    test "deletes the page" do
      %{id: id} = page = insert(:page)

      assert {:ok, %Page{}} = Content.delete_page(page)
      assert_raise NoResultsError, fn -> Content.get_page!(id) end
    end
  end

  describe "change_page/1" do
    test "returns a page changeset" do
      page = insert(:page)

      assert %Changeset{} = Content.change_page(page)
    end
  end
end

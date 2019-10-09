defmodule IvRomance.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false

  alias IvRomance.Content.Page
  alias IvRomance.Repo

  @doc """
  Gets a single page by its path.

  Raises `Ecto.NoResultsError` if the Page does not exist.

  ## Examples

      iex> get_page!("/test")
      %Page{}

      iex> get_page!("no-existed")
      ** (Ecto.NoResultsError)

  """
  def get_page!(path) do
    from(
      page in Page,
      where: page.path == ^path
    )
    |> Repo.one!()
  end
end

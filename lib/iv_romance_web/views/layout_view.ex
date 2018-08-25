defmodule IvRomanceWeb.LayoutView do
  use IvRomanceWeb, :view

  def title(%{assigns: %{title: title}}), do: title
  def title(_conn), do: "Default title"
end

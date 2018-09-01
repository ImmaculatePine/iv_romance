defmodule IvRomanceWeb.LayoutView do
  use IvRomanceWeb, :view

  def title(%{assigns: %{title: title}}), do: title
  def title(_conn), do: gettext("Ivanovo Club of Romance Music «By the Candlelight»")

  def copyright_timestamp, do: "2005–" <> current_year()

  defp current_year do
    DateTime.utc_now()
    |> Map.fetch!(:year)
    |> Integer.to_string()
  end
end

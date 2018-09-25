defmodule IvRomanceWeb.LayoutView do
  use IvRomanceWeb, :view

  @tracking_id Application.get_env(:iv_romance, :google_analytics)[:tracking_id]

  def title(%{assigns: %{title: title}}), do: title
  def title(_conn), do: gettext("Ivanovo Club of Romance Music «By the Candlelight»")

  def copyright_timestamp, do: "2005–" <> current_year()

  def tracking_id, do: @tracking_id

  def has_tracking_id?, do: is_binary(tracking_id()) && tracking_id() != ""

  defp current_year do
    DateTime.utc_now()
    |> Map.fetch!(:year)
    |> Integer.to_string()
  end
end

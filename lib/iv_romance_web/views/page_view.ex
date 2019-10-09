defmodule IvRomanceWeb.PageView do
  use IvRomanceWeb, :view

  def sanitize_markdown(body) do
    body
    |> to_markdown()
    |> HtmlSanitizeEx.markdown_html()
    |> raw()
  end

  defp to_markdown(body) do
    case Earmark.as_html(body) do
      {:ok, markdown, []} -> markdown
      _ -> body
    end
  end
end

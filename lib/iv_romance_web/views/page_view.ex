defmodule IvRomanceWeb.PageView do
  use IvRomanceWeb, :view

  def sanitize_markdown(body) do
    body
    |> to_markdown()
    |> HtmlSanitizeEx.markdown_html()
    |> raw()
  end

  defp to_markdown(body) do
    with {:ok, markdown, []} <- Earmark.as_html(body) do
      markdown
    else
      _ -> body
    end
  end
end

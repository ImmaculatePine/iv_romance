defmodule IvRomanceWeb.LayoutViewTest do
  use IvRomanceWeb.ConnCase, async: true

  alias IvRomanceWeb.LayoutView

  describe "title/1" do
    test "returns title from connection assigns if present" do
      title = "Some title"
      assert title == LayoutView.title(%{assigns: %{title: title}})
    end

    test "returns default title otherwise" do
      assert "Default title" == LayoutView.title(%{assigns: %{}})
    end
  end
end

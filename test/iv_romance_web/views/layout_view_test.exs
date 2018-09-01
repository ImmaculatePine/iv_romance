defmodule IvRomanceWeb.LayoutViewTest do
  use IvRomanceWeb.ConnCase, async: true

  import IvRomanceWeb.Gettext

  alias IvRomanceWeb.LayoutView

  describe "title/1" do
    test "returns title from connection assigns if present" do
      title = "Some title"
      assert LayoutView.title(%{assigns: %{title: title}}) == title
    end

    test "returns default title otherwise" do
      assert LayoutView.title(%{assigns: %{}}) ==
               gettext("Ivanovo Club of Romance Music «By the Candlelight»")
    end
  end
end

defmodule IvRomanceWeb.PageViewTest do
  use IvRomanceWeb.ConnCase, async: true

  alias IvRomanceWeb.PageView

  describe "sanitize_markdown/1" do
    @markdown """
    # Title

    ## Subtitle

    * One
    * Two
    * Three

    Test test test

    <script>alert(1)</script>
    """

    @html """
    <h1>Title</h1>
    <h2>Subtitle</h2>
    <ul>
    <li>One
    </li>
    <li>Two
    </li>
    <li>Three
    </li>
    </ul>
    <p>Test test test</p>
    <p>alert(1)</p>
    """

    test "renders and sanitizes markdown" do
      assert PageView.sanitize_markdown(@markdown) == {:safe, @html}
    end
  end
end

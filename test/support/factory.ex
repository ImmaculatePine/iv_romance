defmodule IvRomance.Factory do
  use ExMachina.Ecto, repo: IvRomance.Repo

  alias IvRomance.Content.Page

  def page_factory do
    %Page{
      path: sequence(:path, &"/page/#{&1}"),
      title: sequence(:title, &"Page #{&1}"),
      body: sequence(:page, &"Page #{&1} body")
    }
  end
end

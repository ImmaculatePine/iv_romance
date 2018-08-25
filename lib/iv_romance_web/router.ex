defmodule IvRomanceWeb.Router do
  use IvRomanceWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :admin_layout do
    plug(:put_layout, {IvRomanceWeb.LayoutView, :admin})
  end

  scope "/admin", IvRomanceWeb.Admin, as: :admin do
    pipe_through([:browser, :admin_layout])

    get("/", PageController, :index, as: :root)
    resources("/pages", PageController, except: [:show])
  end

  scope "/", IvRomanceWeb do
    pipe_through(:browser)

    get("/*path", PageController, :show)
  end
end

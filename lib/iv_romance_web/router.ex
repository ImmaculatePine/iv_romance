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

  pipeline :auth do
    plug(:put_layout, {IvRomanceWeb.LayoutView, :auth})
  end

  pipeline :admin do
    plug(:put_layout, {IvRomanceWeb.LayoutView, :admin})
    plug(IvRomance.Admin.Auth.Plug)
  end

  scope "/admin", IvRomanceWeb.Admin, as: :admin do
    pipe_through([:browser, :auth])
    resources("/sessions", SessionController, only: [:new, :create, :delete])
  end

  scope "/admin", IvRomanceWeb.Admin, as: :admin do
    pipe_through([:browser, :admin, :authenticate_user])
    get("/", PageController, :index, as: :root)
    resources("/pages", PageController, except: [:show])
  end

  scope "/", IvRomanceWeb do
    pipe_through(:browser)

    get("/*path", PageController, :show)
  end
end

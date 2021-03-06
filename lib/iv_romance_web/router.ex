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
    plug(IvRomanceWeb.Plugs.AcceptHeader)
    plug(IvRomance.Admin.Auth.Plug, source: :auth_header)
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
    resources("/uploads", UploadController, only: [:index, :create, :delete])

    resources("/galleries", GalleryController, except: [:show]) do
      resources("/images", ImageController, only: [:index])
    end

    resources("/media", MediaObjectController, except: [:show])
  end

  scope "/api/admin", IvRomanceWeb.Admin, as: :api_admin do
    pipe_through([:api, :authenticate_user])

    resources("/galleries", GalleryController, only: []) do
      resources("/images", ImageController, only: [:index, :create, :delete])
    end
  end

  scope "/", IvRomanceWeb do
    pipe_through(:browser)

    resources("/photo", GalleryController, only: [:index, :show])
    resources("/media", MediaObjectController, only: [:index])

    get("/*path", PageController, :show)
  end
end

defmodule GenialaisWeb.Router do
  use GenialaisWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
    extensions: [PowInvitation]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug GenialaisWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :admin do
    plug GenialaisWeb.Plugs.EnsureRole, :admin
  end

  scope "/", GenialaisWeb do
    pipe_through [:browser]

    get "/", PageController, :index
  end

  scope "/", Pow.Phoenix, as: "pow" do
    pipe_through [:browser, :protected]
    
    resources "/registration", RegistrationController, singleton: true, only: [:edit, :update, :delete]
  end

  scope "/", PowInvitation.Phoenix, as: "pow_invitation" do
    pipe_through [:browser, :protected, :admin]

    resources "/invitations", InvitationController, only: [:new, :create, :show]
  end

  scope "/" do
    pipe_through :browser

    pow_session_routes()
    pow_extension_routes()
  end

  scope "/admin", GenialaisWeb do
    pipe_through [:browser, :protected, :admin]

    get "/", AdminController, :index
    post "/", AdminController, :update
    delete "/:uid", AdminController, :delete
  end

  scope "/user", GenialaisWeb do
    pipe_through [:browser, :protected]

    post "/", UserController, :update
  end

  scope "/individuals", GenialaisWeb do
    pipe_through [:browser, :protected]

    get "/", IndividualController, :index
    get "/new", IndividualController, :new
    get "/:id", IndividualController, :show
    post "/search", IndividualController, :search
    post "/create", IndividualController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", GenialaisWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: GenialaisWeb.Telemetry
    end
  end
end

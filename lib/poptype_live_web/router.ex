defmodule PoptypeLiveWeb.Router do
  use PoptypeLiveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PoptypeLiveWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PoptypeLiveWeb do
    pipe_through :browser
    live "/", PageLive, :index

    live "/posts", PostLive.Index, :index
    live "/posts/new", PostLive.Index, :new
    live "/posts/:id/edit", PostLive.Index, :edit

    live "/posts/:id", PostLive.Show, :show
    live "/posts/:id/show/edit", PostLive.Show, :edit

    live "/stories", StoryLive.Index, :index    
    live "/stories/drafts", StoryLive.Index, :drafts    
    live "/stories/posted", StoryLive.Index, :posted    
    live "/stories/archived", StoryLive.Index, :archived    
    live "/stories/new", StoryLive.Index, :new
    live "/stories/:id/edit", StoryLive.Index, :edit
    live "/stories/:id", StoryLive.Show, :show
    live "/stories/:id/show/edit", StoryLive.Show, :edit


    live "/subscribers", SubscriberLive.Index, :index
    live "/subscribers/new", SubscriberLive.Index, :new
    live "/subscribers/:id/edit", SubscriberLive.Index, :edit

    live "/subscribers/:id", SubscriberLive.Show, :show
    live "/subscribers/:id/show/edit", SubscriberLive.Show, :edit

    live "/insights", InsightLive.Index, :index
    live "/insights/new", InsightLive.Index, :new
    live "/insights/:id/edit", InsightLive.Index, :edit

    live "/insights/:id", InsightLive.Show, :show
    live "/insights/:id/show/edit", InsightLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", PoptypeLiveWeb do
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
      live_dashboard "/dashboard", metrics: PoptypeLiveWeb.Telemetry
    end
  end
end

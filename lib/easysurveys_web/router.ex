defmodule EasysurveysWeb.Router do
  use EasysurveysWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EasysurveysWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/create_form", PageController, :create_form
    get "/fill_form", PageController, :fill_form
    get "/results", PageController, :results
    get "/contact", PageController, :contact

    post "/save_form", PageController, :save_form
    post "/get_form", PageController, :get_form
    post "/save_results", PageController, :save_results
    post "/get_results", PageController, :get_results
  end

  # Other scopes may use custom stacks.
  # scope "/api", EasysurveysWeb do
  #   pipe_through :api
  # end
end

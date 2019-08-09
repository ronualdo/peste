defmodule PesteApiWeb.Router do
  use PesteApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PesteApiWeb do
    pipe_through :api
  end
end

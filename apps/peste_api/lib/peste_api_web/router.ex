defmodule PesteApiWeb.Router do
  use PesteApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", PesteApiWeb do
    pipe_through :api

    post "/webhook", TelegramController, :webhook
  end
end

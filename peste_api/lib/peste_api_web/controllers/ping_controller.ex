defmodule PesteApiWeb.PingController do
  use PesteApiWeb, :controller

  def ping(conn, _params) do
    json(conn, %{ping: true})
  end
end

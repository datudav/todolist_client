defmodule TodolistappWeb.PageController do
  use TodolistappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

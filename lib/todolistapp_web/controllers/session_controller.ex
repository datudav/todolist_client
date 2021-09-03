defmodule TodolistappWeb.SessionController do
  use TodolistappWeb, :controller

  alias Todolistapp.Account
  alias Todolistapp.Account.User

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def sign_in(conn, %{"sign_in" => params}) do
    case Account.sign_in(params) do
      {:ok, body} ->
        conn
        |> put_session(:user_id, body.user_id)
        |> put_flash(:info, "Sign in successful")
        |> IO.inspect()
        |> redirect(to: Routes.dashboard_path(conn, :index))
      {:error, _body} ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> render("index.html")
    end
  end
end

defmodule TodolistappWeb.DashboardController do
  use TodolistappWeb, :controller

  alias Todolistapp.Dashboard

  def index(conn, _params) do
    access_token = get_session(conn, :access_token)
    user_id = get_session(conn, :current_user_id)
    {:ok, board, board_id} = Dashboard.load_board(%{"access_token" => access_token, "user_id" => user_id})
    render(conn, "index.html", board: board, access_token: access_token, user_id: user_id, board_id: board_id)
  end
end

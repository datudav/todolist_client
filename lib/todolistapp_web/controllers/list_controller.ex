defmodule TodolistappWeb.ListController do
  use TodolistappWeb, :controller

  alias Todolistapp.List

  def index(conn, params) do
    access_token = get_session(conn, :access_token)
    user_id = get_session(conn, :current_user_id)
    list_id = Map.get(params, "list_id")
    {:ok, list} = List.get_list(%{"access_token" => access_token, "user_id" => user_id, "list_id" => list_id})
    {:ok, tasks} = List.list_tasks(%{"access_token" => access_token, "user_id" => user_id, "list_id" => list_id})
    render(conn, "index.html", access_token: access_token, user_id: user_id, list_id: list_id, list_title: list["data"]["title"], tasks: tasks)
  end
end

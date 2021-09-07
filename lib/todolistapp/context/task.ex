defmodule Todolistapp.Task do
  alias Todolistapp.Board.Board
  alias Todolistapp.List.List
  alias Todolistapp.Task.Task

  @success_codes 200..399

  def list_tasks(params) do
    with {token, _} = Map.pop(params, "access_token"),
      {list_id, _} = Map.pop(params, "list_id"),
      {:ok, %{body: body, status: status}} when status in @success_codes <-
        Tesla.get(client(token), "/tasks", query: [params: [list_id: list_id]]) do
        {:ok, body}
    else
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  def create_task(params) do
    with {token, _} = Map.pop(params, "access_token"),
      {list_id, _} = Map.pop(params, "list_id"),
      {:ok, %{body: body, status: status}} when status in @success_codes <-
        Tesla.get(client(token), "/tasks", query: [params: [list_id: list_id]]) do
        {:ok, body}
    else
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  defp client(token) do
    middlewares = [
      {Tesla.Middleware.BaseUrl, "http://localhost:5000/api/v1"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"Authorization", "#{token}"}]},
      Tesla.Middleware.PathParams
    ]

    Tesla.client(middlewares)
  end
end

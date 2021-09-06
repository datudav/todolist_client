defmodule Todolistapp.Dashboard do
  alias Todolistapp.Board.Board
  alias Todolistapp.List.List

  @success_codes 200..399

  def load_board(params) do
    {token, params} = Map.pop(params, "access_token")
    {owner_id, _} = Map.pop(params, "user_id")
    client = client(token)
    with {:ok, %{:body => board, :status => status}} when status in @success_codes <- Tesla.get(client, "/board", query: [params: [owner_id: owner_id]]),
      {:ok, %{:body => lists, :status => status}} when status in @success_codes <- Tesla.get(client(token), "/lists", query: [params: [board_id: Elixir.List.first(board["data"])["board_id"]]]) do
        {:ok, lists, Elixir.List.first(board["data"])["board_id"]}
    end
  end

  def get_user_board(params) do
    with {token, params} = Map.pop(params, "access_token"),
      {owner_id, _} = Map.pop(params, "user_id"),
      {:ok, %{:body => body, :status => status}} when status in @success_codes <-
        Tesla.get(client(token), "/board", query: [params: [owner_id: owner_id]]) do
        {:ok, body}
    else
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  def get_board_permission(params) do
    with {token, _} = Map.pop(params, "access_token"),
      {board_id, _} = Map.pop(params, "board_id"),
      {:ok, %{:body => body, :status => status}} when status in @success_codes <-
        Tesla.get(client(token), "/board_permission", query: [params: [board_id: board_id]]) do
        {:ok, body}
    else
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  def list_lists(params) do
    with {token, _} = Map.pop(params, "access_token"),
      {board_id, _} = Map.pop(params, "board_id"),
      {:ok, %{body: body, status: status}} when status in @success_codes <-
        Tesla.get(client(token), "/lists", query: [params: [board_id: board_id]]) do
        {:ok, body}
    else
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  def create_list(params) do
    with {token, params} = Map.pop(params, "access_token"),
      {:ok, %{body: body, status: status}} when status in @success_codes <- Tesla.post(client(token), "/lists", %{"list" => params}) do
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

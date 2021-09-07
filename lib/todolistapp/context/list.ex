defmodule Todolistapp.List do

  @success_codes 200..399

  def get_list(params) do
    with {token, _} = Map.pop(params, "access_token"),
      {list_id, _} = Map.pop(params, "list_id"),
      {:ok, %{body: body, status: status}} when status in @success_codes <-
        Tesla.get(client(token), "/lists/:id", opts: [path_params: [id: list_id]]) do
        {:ok, body}
    else
      {:error, %{body: body}} -> {:error, body}
    end
  end

  def list_tasks(params) do
    with {token, _} = Map.pop(params, "access_token"),
      {list_id, _} = Map.pop(params, "list_id"),
      IO.inspect(list_id),
      {:ok, %{body: body, status: status}} when status in @success_codes <-
        Tesla.get(client(token), "/tasks", query: [params: [list_id: list_id]]) do
        {:ok, body}
    else
      {:error, %{body: body}} -> {:error, body}
    end
  end

  def create_task(params) do
    with {token, params} = Map.pop(params, "access_token"),
      {:ok, %{body: body, status: status}} when status in @success_codes <- Tesla.post(client(token), "/tasks", %{"task" => params}) do
        {:ok, body}
    else
      {:error, %{body: body}} -> {:error, body}
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

defmodule Todolistapp.List do
  alias Todolistapp.List.List

  @success_codes 200..399

  def list_lists(request) do
    with {:ok, %{body: body, status: status}} when status in @success_codes <-
      Tesla.get(client(), "/lists") do
        {:ok, body}
    else
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  defp client() do
    middlewares = [
      {Tesla.Middleware.BaseUrl, "http://localhost:5000/api/v1"},
      Tesla.Middleware.JSON,
      Tesla.Middleware.PathParams
    ]

    Tesla.client(middlewares)
  end
end

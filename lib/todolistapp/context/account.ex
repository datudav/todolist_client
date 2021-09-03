defmodule Todolistapp.Account do
  alias Todolistapp.Account.User

  @success_codes 200..399

  def sign_up(request) do
    with {:ok, %{body: body, status: status}} when status in @success_codes <-
      Tesla.post(client(), "/users", %{:user => %{:email => request["email"], :password => request["password"]}}) do
        {:ok, body}
    else
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  def sign_in(request) do
    with {:ok, %{:body => body, :status => status}} when status in @success_codes <-
      Tesla.post(client(), "/users/sign_in", %{:email => request["email"], :password => request["password"]}) do
        {:ok, %{:email => body["data"]["email"], :user_id => body["data"]["user_id"]}}
    else
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  def update(request) do
    with path_params = Map.take(request, [:user_id]),
      {:ok, %{:body => body, :status => status}} when status in @success_codes <-
      Tesla.patch(client(), "/users", %{:email => request.email, :password => request.password}, opts: [path_params: path_params]) do
        {:ok, body}
    else
      {:ok, %{body: body}} -> {:error, body}
    end
  end


  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  defp client() do
    # api_base_url = Application.get_env(:todolistapp, :api_base_url)

    # middlewares = [
    #   {Tesla.Middleware.BaseUrl, api_base_url},
    #   Tesla.Middleware.JSON
    # ]

    middlewares = [
      {Tesla.Middleware.BaseUrl, "http://localhost:5000/api/v1"},
      Tesla.Middleware.JSON,
      Tesla.Middleware.PathParams
    ]

    Tesla.client(middlewares)
  end
end

defmodule Todolistapp.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todolistapp.Account.User

  @primary_key {:user_id, :binary_id, autogenerate: true}
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
  end
end

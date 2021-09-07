defmodule Todolistapp.List.List do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todolistapp.List.List

  @primary_key {:list_id, :binary_id, autogenerate: true}
  schema "list" do
    field :title, :string
    field :description, :string
    field :board_id, Ecto.UUID
    field :creator_id, Ecto.UUID

    timestamps()
  end

  @doc false
  def changeset(%List{} = list, attrs) do
    list
    |> cast(attrs, [:title, :description, :board_id, :creator_id])
    |> validate_required([:title, :description, :board_id, :creator_id])
  end
end

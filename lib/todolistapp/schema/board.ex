defmodule Todolistapp.Board.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todolistapp.Board.Board

  @primary_key {:board_id, :binary_id, autogenerate: true}
  schema "board" do
    field(:title, :string, null: false)
    field(:description, :string, null: false)
    field(:owner_id, Ecto.UUID, null: false)

    timestamps()
  end

  @doc false
  def changeset(%Board{} = board, attrs) do
    board
    |> cast(attrs, [:title, :description, :owner_id])
    |> validate_required([:title, :description, :owner_id])
  end
end

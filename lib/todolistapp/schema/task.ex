defmodule Todolistapp.Task.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todolistapp.Task.Task

  @primary_key {:task_id, :binary_id, autogenerate: true}
  schema "task" do
    field :description, :string
    field :title, :string
    field :rank, :decimal
    field :list_id, Ecto.UUID
    field :assigned_to_id, Ecto.UUID, null: true

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :rank, :list_id, :assigned_to_id])
    |> validate_required([:title, :description, :list_id])
  end
end

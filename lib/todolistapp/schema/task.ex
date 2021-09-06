defmodule Todolistapp.TaskManager.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Todolistapp.TaskManager.Task

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tasks" do
    field :description, :string
    field :title, :string
    field :rank, :decimal

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :rank])
    |> validate_required([:title, :description])
  end
end
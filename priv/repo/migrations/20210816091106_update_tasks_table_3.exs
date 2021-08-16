defmodule Todolistapp.Repo.Migrations.UpdateTasksTable3 do
  use Ecto.Migration

  def change do
    Todolistapp.Repo.query("""
    ALTER TABLE tasks DROP COLUMN id;
    """)
  end
end

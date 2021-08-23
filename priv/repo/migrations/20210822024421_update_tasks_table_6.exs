defmodule Todolistapp.Repo.Migrations.UpdateTasksTable6 do
  use Ecto.Migration

  def change do
    Todolistapp.Repo.query("""
    ALTER TABLE tasks ADD COLUMN rank decimal;
    """)
  end
end

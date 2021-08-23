defmodule Todolistapp.Repo.Migrations.UpdateTasksTable8 do
  use Ecto.Migration

  def change do
    Todolistapp.Repo.query("""
    ALTER TABLE tasks ALTER COLUMN rank SET NOT NULL;
    """)
  end
end

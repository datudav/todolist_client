defmodule Todolistapp.Repo.Migrations.UpdateTasksTable5 do
  use Ecto.Migration

  def change do
    Todolistapp.Repo.query("""
    ALTER TABLE tasks ADD COLUMN id uuid DEFAULT uuid_generate_v4();
    """)
  end
end

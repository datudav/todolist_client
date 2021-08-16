defmodule Todolistapp.Repo.Migrations.UpdateTasksTable2 do
  use Ecto.Migration

  def change do
    Todolistapp.Repo.query("""
      ALTER TABLE tasks DROP CONSTRAINT tasks_pkey;
    """)
  end
end

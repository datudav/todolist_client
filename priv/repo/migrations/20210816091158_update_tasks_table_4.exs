defmodule Todolistapp.Repo.Migrations.UpdateTasksTable4 do
  use Ecto.Migration

  def change do
    Todolistapp.Repo.query("""
    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    """)
  end
end

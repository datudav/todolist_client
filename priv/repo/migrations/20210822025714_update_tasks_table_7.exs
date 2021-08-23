defmodule Todolistapp.Repo.Migrations.UpdateTasksTable7 do
  use Ecto.Migration

  def change do
    Todolistapp.Repo.query("""
    UPDATE tasks
    SET rank = extract(epoch from inserted_at);
    """)
  end
end

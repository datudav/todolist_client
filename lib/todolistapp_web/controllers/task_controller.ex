defmodule TodolistappWeb.TaskController do
  use TodolistappWeb, :controller

  alias Todolistapp.TaskManager
  alias Todolistapp.TaskManager.Task

  def index(conn, _params) do
    tasks = TaskManager.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
   changeset = TaskManager.change_task(%Task{})
   render(conn, "new.html", changeset: changeset)
 end

  def create(conn, %{"task" => task_params}) do
    case TaskManager.create_task(task_params) do
      {:ok, task} ->
        conn
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = TaskManager.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = TaskManager.get_task!(id)
    changeset = TaskManager.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = TaskManager.get_task!(id)

    case TaskManager.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = TaskManager.get_task!(id)
    {:ok, _task} = TaskManager.delete_task(task)

    conn
    |> redirect(to: Routes.task_path(conn, :index))
  end
end

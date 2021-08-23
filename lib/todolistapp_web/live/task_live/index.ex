defmodule TodolistappWeb.TaskLive.Index do
  use TodolistappWeb, :live_view
  alias Todolistapp.TaskManager
  alias Todolistapp.TaskManager.Task

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, tasks: list_tasks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task")
    |> assign(:task, TaskManager.get_task!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "To-Do List")
    |> assign(:task, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task = TaskManager.get_task!(id)
    {:ok, _} = TaskManager.delete_task(task)

    {:noreply, assign(socket, :tasks, list_tasks())}
  end

  @impl true
  def handle_event("rank_up", %{"id" => id}, socket) do
    task = TaskManager.get_task!(id)
    {:ok, _} = TaskManager.rank_up(task)

    {:noreply, assign(socket, :tasks, list_tasks())}
  end

  @impl true
  def handle_event("rank_down", %{"id" => id}, socket) do
    task = TaskManager.get_task!(id)
    {:ok, _} = TaskManager.rank_down(task)

    {:noreply, assign(socket, :tasks, list_tasks())}
  end

  defp list_tasks do
    TaskManager.list_tasks()
  end
end

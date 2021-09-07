defmodule TodolistappWeb.Dashboard.Index do
  use TodolistappWeb, :live_view

  alias Todolistapp.List.List

  def mount(_params, session, socket) do
    assigns = Map.take(session, ["access_token", "user_id", "board_id", "board", "csrf_token"])
    atom_key_map = for {key, val} <- assigns, into: %{}, do: {String.to_atom(key), val}
    {:ok, assign(socket, atom_key_map)}
  end

  # def handle_event(params, _url, socket) do
  #   {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  # end

  def handle_event("add_list", params, socket) do
    {:noreply, apply_action(socket, :new, params)}
  end

  def handle_event("list_tasks", params, socket) do

  end

  # def handle_event("delete", %{"id" => id}, socket) do
  #   task = TaskManager.get_task!(id)
  #   {:ok, _} = TaskManager.delete_task(task)

  #   {:noreply, assign(socket, :tasks, list_tasks())}
  # end

  def apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New List")
    |> assign(:list, %List{})
    |> assign(:live_action, :new)
  end


  def render(assigns) do
    Phoenix.View.render(TodolistappWeb.DashboardView, "dashboard_index.html", assigns)
  end
end

defmodule TodolistappWeb.List.Index do
  use TodolistappWeb, :live_view

  alias Todolistapp.Task.Task

  def mount(_params, session, socket) do
    assigns = Map.take(session, ["access_token", "user_id", "list_id", "tasks", "csrf_token"])
    atom_key_map = for {key, val} <- assigns, into: %{}, do: {String.to_atom(key), val}
    {:ok, assign(socket, atom_key_map)}
  end

  def render(assigns) do
    Phoenix.View.render(TodolistappWeb.ListView, "list_index.html", assigns)
  end

  def handle_event("add_task", params, socket) do
    {:noreply, apply_action(socket, :new, params)}
  end

  def apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{})
    |> assign(:live_action, :new)
  end
end

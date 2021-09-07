defmodule TodolistappWeb.List.FormComponent do
  use TodolistappWeb, :live_component

  alias Todolistapp.List

  def render(assigns) do
    Phoenix.View.render(TodolistappWeb.ListView, "task_form_component.html", assigns)
  end

  def handle_event("save", %{"task" => task_params}, socket) do
    save_task(socket, :new, task_params)
  end

  defp save_task(socket, :new, task_params) do
    access_token = socket.assigns.access_token
    list_id = socket.assigns.list_id
    merged_map = Map.merge(%{"access_token" => access_token, "list_id" => list_id}, task_params)
    case List.create_task(merged_map) do
      {:ok, _task} ->
        {:noreply,
         socket
         # |> put_flash(:info, "Task created successfully")
         |> push_redirect(to: Routes.list_path(socket, :index, %{"list_id" => list_id}))}
    end
  end
end

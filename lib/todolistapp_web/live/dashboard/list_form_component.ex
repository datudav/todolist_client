defmodule TodolistappWeb.Dashboard.FormComponent do
  use TodolistappWeb, :live_component

  alias Todolistapp.Dashboard

  def render(assigns) do
    Phoenix.View.render(TodolistappWeb.DashboardView, "list_form_component.html", assigns)
  end

  # @impl true
  # def update(%{list: list} = assigns, socket) do
  #   changeset = TaskManager.change_list(task)

  #   {:ok,
  #    socket
  #    |> assign(assigns)
  #    |> assign(:changeset, changeset)}
  # end

  # @impl true
  # def handle_event("validate", %{"list" => list_params}, socket) do
  #   changeset =
  #     socket.assigns.list
  #     |> TaskManager.change_list(list_params)
  #     |> Map.put(:action, :validate)

  #   {:noreply, assign(socket, :changeset, changeset)}
  # end

  def handle_event("save", %{"list" => list_params}, socket) do
    save_list(socket, :new, list_params)
  end

  # defp save_list(socket, :edit, list_params) do
  #   case TaskManager.update_list(socket.assigns.list, list_params) do
  #     {:ok, _list} ->
  #       {:noreply,
  #        socket
  #        |> put_flash(:info, "Task updated successfully")
  #        |> push_redirect(to: socket.assigns.return_to)}

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       {:noreply, assign(socket, :changeset, changeset)}
  #   end
  # end

  defp save_list(socket, :new, list_params) do
    access_token = socket.assigns.access_token
    board_id = socket.assigns.board_id
    user_id = socket.assigns.user_id
    merged_map = Map.merge(%{"access_token" => access_token, "board_id" => board_id, "creator_id" => user_id}, list_params)
    case Dashboard.create_list(merged_map) do
      {:ok, _list} ->
        {:noreply,
         socket
         # |> put_flash(:info, "Task created successfully")
         |> push_redirect(to: Routes.dashboard_path(socket, :index))}
    end
  end
end

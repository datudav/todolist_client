defmodule TodolistappWeb.SessionLive.Index do
  use TodolistappWeb, :live_view

  alias Todolistapp.Account

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(TodolistappWeb.SessionView, "index.html", assigns)
  end

  def handle_event("sign_in", %{"sign_in" => params}, socket) do
    case Account.sign_in(params) do
      {:ok, _body} ->
        {:noreply, socket}
      {:error, _body} ->
        {:noreply, put_flash(socket, :error, "Invalid credentials")}
    end
  end
end

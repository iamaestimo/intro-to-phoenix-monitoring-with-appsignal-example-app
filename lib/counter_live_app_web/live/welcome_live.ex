defmodule CounterLiveAppWeb.WelcomeLive do
  use CounterLiveAppWeb, :live_view

  def mount(_params, _session, socket) do
    { :ok, assign(socket, message: "Welcome to Counter App!") }
  end

  def render(assigns) do
    ~H"""
    <h1><%= @message %></h1>
    """
  end

end

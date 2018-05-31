defmodule TodoWeb.TodoView do
  use TodoWeb, :view

  def server_url do
    System.get_env("SERVER_URL") || TodoWeb.Endpoint.config(:server_url)
  end
end

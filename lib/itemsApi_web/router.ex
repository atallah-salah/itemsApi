defmodule ItemsApiWeb.Router do
  use ItemsApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :itemsApi, swagger_file: "swagger.json"
  end

  scope "/api", ItemsApiWeb do
    pipe_through :api
    get "/items", ItemController, :get_all_available_items
    get "/items/deleted", ItemController, :get_all_deleted_items
    get "/items/:id", ItemController, :get_one_item

    post "/items", ItemController, :insert_item
    put "/items/:id", ItemController, :update_item
    delete "/items/:id", ItemController, :delete_item

    resources "/items", ItemsController
  end

  scope "/", ItemsApiWeb do

  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Items App"
      }
    }
  end
end

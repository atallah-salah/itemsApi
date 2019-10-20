defmodule ItemsApiWeb.ItemsController do
  use ItemsApiWeb, :controller
  use PhoenixSwagger

  alias ItemsApi.Items

  action_fallback(ItemsApiWeb.FallbackController)

  def swagger_definitions do
    %{
      Items:
        swagger_schema do
          title("Items")
          description("items")

          properties do
            id(:string, "Item id", required: true)
            title(:string, "Item title", required: true)
            description(:string, "Item description", required: true)
            thumbnail_url(:string,"thumbnail_url")
            is_deleted(:boolean, false, required: true)
            inserted_at(:string, "Creation timestamp", format: :datetime)
            updated_at(:string, "Update timestamp", format: :datetime)
          end

          example(%{
            title: "Item 1",
            description: "item description",
          })
        end,
      ItemRequest:
        swagger_schema do
          title("ItemRequest")
          description("POST body for creating a item")
          property(:item, Schema.ref(:Items), "The item details")
        end,
      ItemResponse:
        swagger_schema do
          title("ItemResponse")
          description("Response schema for single item")
          property(:item, Schema.ref(:Items), "The item details")
        end,
      ItemsResponse:
        swagger_schema do
          title("ItemsResponse")
          description("Response schema for multiple items")
          property(:item, Schema.array(:Items), "The items details")
        end
    }
  end

  swagger_path(:index) do
    get("/api/items")
    summary("List items")
    description("List all available items in the database")
    produces("application/json")
    deprecated(false)

    response(200, "OK", Schema.ref(:ItemsResponse),
      example: %{
        data: [
          %{
            _id: "5dab9c413a051e54c4bc75c3",
            title: "item 1",
            description: "item 1 description",
            inserted_at: "2019-02-08T12:34:55Z",
            updated_at: "2019-02-12T13:45:23Z"
          },
          %{
            _id: "2ivb9c413a051e4o44bc79f9",
            title: "item 2",
            description: "item 2 description",
            inserted_at: "2019-02-04T11:24:45Z",
            updated_at: "2019-02-15T23:15:43Z"
          }
        ]
      }
    )
  end


  swagger_path(:show) do
    get("/api/items/{id}")
    summary("One items")
    description("Get one item")
    produces("application/json")
    deprecated(false)
    parameter :id, :path, :string, "_id", required: true, example: "item _id"

    response(200, "OK", Schema.ref(:ItemsResponse),
      example: %{
        data: [
          %{
            _id: "5dab9c413a051e54c4bc75c3",
            title: "item 1",
            description: "item 1 description",
            inserted_at: "2019-02-08T12:34:55Z",
            updated_at: "2019-02-12T13:45:23Z"
          },
          %{
            _id: "2ivb9c413a051e4o44bc79f9",
            title: "item 2",
            description: "item 2 description",
            inserted_at: "2019-02-04T11:24:45Z",
            updated_at: "2019-02-15T23:15:43Z"
          }
        ]
      }
    )
  end

  swagger_path(:delete) do
    delete("/api/items/{id}")
    summary("Delete item")
    description("Delete item")
    produces("application/json")
    deprecated(false)
    parameter :id, :path, :string, "_id", required: true, example: "item _id"

    response(200, "OK", Schema.ref(:ItemsResponse),
      example: %{
        data: [
          %{
            _id: "5dab9c413a051e54c4bc75c3",
            title: "item 1",
            description: "item 1 description",
            inserted_at: "2019-02-08T12:34:55Z",
            updated_at: "2019-02-12T13:45:23Z"
          },
          %{
            _id: "2ivb9c413a051e4o44bc79f9",
            title: "item 2",
            description: "item 2 description",
            inserted_at: "2019-02-04T11:24:45Z",
            updated_at: "2019-02-15T23:15:43Z"
          }
        ]
      }
    )
  end

  swagger_path(:update) do
    put("/api/items/{id}")
    summary("Update item")
    description("Update item")
    produces("application/json")
    deprecated(false)
    parameter :id, :path, :string, "_id", required: true, example: "item _id"

    parameter(:title, :query, "Title", "The title details",
      example: %{
        title: %{title: "Joe", email: "Joe1@mail.com"}
      }
    )

    parameter(:description, :query, "Description", "The description details",
      example: %{
        description: %{description: "Joe", email: "Joe1@mail.com"}
      }
    )

    response(200, "OK", Schema.ref(:ItemsResponse),
      example: %{
        data: [
          %{
            _id: "5dab9c413a051e54c4bc75c3",
            title: "item 1",
            description: "item 1 description",
            inserted_at: "2019-02-08T12:34:55Z",
            updated_at: "2019-02-12T13:45:23Z"
          },
          %{
            _id: "2ivb9c413a051e4o44bc79f9",
            title: "item 2",
            description: "item 2 description",
            inserted_at: "2019-02-04T11:24:45Z",
            updated_at: "2019-02-15T23:15:43Z"
          }
        ]
      }
    )
  end

  swagger_path(:create) do
    post("/api/items")
    summary("Create item")
    description("Creates a new item")
    consumes("application/json")
    produces("application/json")
    deprecated(false)


  parameter(:title, :query, "Title", "The title details",
    example: %{
      title: %{title: "Joe", email: "Joe1@mail.com"}
    }
  )

  parameter(:description, :query, "Description", "The description details",
    example: %{
      description: %{description: "Joe", email: "Joe1@mail.com"}
    }
  )

    response(201, "Item created OK", Schema.ref(:ItemResponse),
      example: %{
        data: %{
          _id: "5dab9c413a051e54c4bc75c3",
          title: "new item",
          description: "item description",
          inserted_at: "2019-02-08T12:34:55Z",
          updated_at: "2019-02-12T13:45:23Z"
        }
      }
    )
  end
end

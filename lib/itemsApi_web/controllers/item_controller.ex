defmodule ItemsApiWeb.ItemController do
  use ItemsApiWeb, :controller
  import Ecto.Query

  def get_all_available_items(conn, _params) do
    query = from item in Items, where: item.is_deleted == false, select: item
    list  = ItemsApi.Repo.all(query)
    text(conn, inspect list)
  end

  def get_all_deleted_items(conn, _params) do
    query = from item in Items,  where: item.is_deleted == true, select: item
    list  = ItemsApi.Repo.all(query)
    text(conn, inspect list)
  end

  def get_one_item(conn, %{"id" => id}) do
    query = from item in Items, where: item."_id" == ^id, select: item
    result = ItemsApi.Repo.one(query)

    text(conn, inspect result)
  end

  def insert_item(conn, %{"title" => title, "description" => description}) do
    result = %Items{title: title, description: description}
    |> Ecto.Changeset.change(%{})
    |> ItemsApi.Repo.insert()

    text(conn, inspect result)
  end

  def update_item(conn, %{"id" => id ,"title" => title, "description" => description }) do
    result = from(item in Items, where: item."_id" == ^id, update: [set: [title: ^title],set: [description: ^description]])
    |> ItemsApi.Repo.update_all([])

    # get updated item
    query = from item in Items, where: item."_id" == ^id, select: item
    item = ItemsApi.Repo.one(query)

    text(conn, inspect {:ok , item})
  end

  def delete_item(conn, %{"id" => id}) do
    result = from(item in Items, where: item."_id" == ^id, update: [set: [is_deleted: true]])
    |> ItemsApi.Repo.update_all([])

    # get deleted item
    query = from item in Items, where: item."_id" == ^id, select: item
    item = ItemsApi.Repo.one(query)

    text(conn, inspect {:ok , item})
  end
end

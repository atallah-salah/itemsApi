defmodule ItemsApi.App do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    tree = [worker(ItemsApi.Repo, []),ItemsApiWeb.Endpoint]
    opts = [name: ItemsApi.Sup, strategy: :one_for_one]
    Supervisor.start_link(tree, opts)
  end

  def config_change(changed, _new, removed) do
    ItemsApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end

end

defmodule ItemsApi.Repo do
  use Ecto.Repo, otp_app: :itemsApi
end

defmodule Items do
  use Ecto.Schema

  @primary_key {:_id, :binary_id, autogenerate: true}
  schema "item" do
    field :title, :string
    field :description , :string
    field :thumbnail_url , :string
    field :is_deleted , :boolean, default: false
    timestamps()
  end
end



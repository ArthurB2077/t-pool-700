defmodule Api.Roles do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias Api.Roles
  alias Api.User
  alias Api.Repo

  @derive {Jason.Encoder, only: [:id, :role_name, :isAuthoriseAdmin, :isAuthoriseManager]}
  schema "roles" do
    field :role_name, :string
    field :isAuthoriseAdmin, :boolean
    field :isAuthoriseManager, :boolean

    timestamps()
  end

  @doc false
  def changeset(roles, attrs) do
    roles
    |> cast(attrs, [:role_name, :isAuthoriseAdmin, :isAuthoriseManager])
    |> validate_required([:role_name])
    |> unique_constraint(:role_name)
  end

end

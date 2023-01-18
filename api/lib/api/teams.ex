defmodule Api.Teams do
  use Ecto.Schema

  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :team_name, :created_by]}
  schema "teams" do
    field :team_name, :string
    field :created_by, :id
  end

  def changeset(teams, attrs) do
    teams
    |> cast(attrs, [:team_name, :created_by])
    |> validate_required([:team_name])
  end

end

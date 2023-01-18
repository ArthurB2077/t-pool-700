defmodule Api.Repo.Migrations.AddTeamTable do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :team_name, :string, null: false
      add :created_by, references(:users)

    end
    create index(:teams, [:created_by])
  end
end

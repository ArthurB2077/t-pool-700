defmodule ApiWeb.TeamsController do
  use ApiWeb, :controller

  import Ecto.Query
  alias Api.Teams
  alias Api.Repo
  alias Api.User

  
  def create(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      teamname = params["team_name"]
      userId = params["userID"]
      user = Repo.one(from u in User, where: u.id == ^userId)
      if (user !== nil) do
        Repo.insert(%Teams{team_name: teamname, created_by: user.id})
        conn |> render(ApiWeb.TeamsView, "create_team.json", status: 201, success: true, message: "Team created")
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "Failed to create team")
      end
    end
  end

  def retrieve(conn, _params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      retrieved = Repo.all(Teams)
      if (retrieved !== nil && retrieved !== []) do
        conn |> render(ApiWeb.TeamsView, "get_teams.json", %{status: 200, success: true, message: "Teams found", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No teams Found"})
      end
    end
  end

  def retrievewithid(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      userId = params["userID"]
      teams = Repo.all(from t in Teams, where: t.created_by == ^userId)
      if (teams !== nil && length(teams) > 0) do
        teamsWithMembers = Enum.map(teams, fn team -> %{id: team.id, team_name: team.team_name, created_by: team.created_by, members: Enum.map(Repo.all(from u in User, join: tm in "team_member", on: tm.user == u.id, where: tm.team == ^team.id), fn uit -> %{id: uit.id, email: uit.email, username: uit.username, role_id: uit.role_id} end)} end)
        conn |> render(ApiWeb.TeamsView, "get_teams.json", %{status: 200, success: true, message: "Manager's teams found", content: teamsWithMembers})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No manager's team"})
      end
    end
  end

end

defmodule ApiWeb.RolesController do
  use ApiWeb, :controller

  import Ecto.Query
  alias Api.Roles
  alias Api.Repo

  def create(conn, %{"role_name" => rolename, "isAuthoriseManager" => isAuthoriseManager, "isAuthoriseAdmin" => isAuthoriseAdmin}) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      %Roles{}
      |> Roles.changeset(%{role_name: rolename, isAuthoriseManager: isAuthoriseManager, isAuthoriseAdmin: isAuthoriseAdmin })
      |> Repo.insert()
      conn |> render(ApiWeb.RolesView, "get_roles.json", status: 201, success: true, message: "Role created", content: %{role_name: rolename, isAuthoriseManager: isAuthoriseManager, isAuthoriseAdmin: isAuthoriseAdmin })
    end
  end

  def retrieve(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      retrieved = Repo.all(Roles)
      if (retrieved !== nil && retrieved !== []) do
        conn |> render(ApiWeb.RolesView, "get_roles.json", %{status: 200, success: true, message: "Roles found", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No Roles Found"})
      end
    end
  end

  def retrievedroits(conn,  %{"roleID" => roleID}) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      roleID = String.to_integer(roleID)
      retrieved = Repo.one(from r in Roles, where: r.id == ^roleID)
      if (retrieved !== nil && retrieved !== []) do
        conn |> render(ApiWeb.RolesView, "get_roles.json", %{status: 200, success: true, message: "Roles found", content: retrieved})
      else
        conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No Roles Found"})
      end
    end
  end

end

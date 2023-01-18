defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  import Ecto.Query

  alias Api.User
  alias Api.Repo
  alias Api.Clocks
  alias Api.Teams

  def retrieveAll(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      email = params["email"]
      username = params["username"]

      if (username === nil || email === nil) do
        if (username !== nil && email === nil) do
          retrieved = Repo.all(from u in User, where: u.username == ^username)
          if (retrieved !== nil && Enum.count(retrieved) !== 0) do
            conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "User matching the given username query retrieved", content: retrieved})
          else
            conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user matching the given username query"})
          end
        else
          if (email !== nil && username === nil) do
            retrieved = Repo.all(from u in User, where: u.email == ^email)
            if (retrieved !== nil && Enum.count(retrieved) !== 0) do
              conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "Users matching the given email query retrieved", content: retrieved})
            else
              conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user matching the given email query"})
            end
          else
            users = Repo.all(User)
            if(users !== nil && Enum.count(users) !== 0) do
              usersWithTeams = Enum.map(users, fn user -> %{id: user.id, email: user.email, username: user.username, role_id: user.role_id, teams: Repo.all(from t in Teams, join: tm in "team_member", on: tm.team == t.id, where: tm.user == ^user.id)} end)
              conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "All users retrieved", content: usersWithTeams})
            else
              conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user found"})
            end
          end
        end
      else
        retrieved = Repo.all(from u in User, join: r in "roles", on: r.id == u.role_id, where: u.username >= ^username, where: u.email <= ^email, select: %{id: u.id, username: u.username,email: u.email, role_id: u.role_id, role_name: r.role_name, isAuthoriseAdmin: r.isAuthoriseAdmin, isAuthoriseManager: r.isAuthoriseManager})
        if(retrieved !== nil && Enum.count(retrieved) !== 0) do
          conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "Users matching the given queries email and username retrieved", content: retrieved})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", %{status: 403, error: "No user the given queries email and username"})
        end
      end
    end
  end

  def retrieve(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      id = params["userID"]
      if(id !== nil) do
        if (is_bitstring(id) || is_integer(id)) do
          if(is_bitstring(id)) do
            id = String.to_integer(id)
          end
          #user = Repo.one(from u in User, join: r in "roles", on: r.id == u.role_id, where: u.id == ^id, select: {u, {r.isAuthoriseAdmin, r.isAuthoriseManager}})
          user = Repo.one(from u in User, join: r in "roles", on: r.id == u.role_id, where: u.id == ^id, select: %{id: u.id, username: u.username,email: u.email, role_id: u.role_id, role_name: r.role_name, isAuthoriseAdmin: r.isAuthoriseAdmin, isAuthoriseManager: r.isAuthoriseManager})

          if(user !== nil) do
            #user = JSON.Encoder.encode(%{user_id: user.id, })
            conn |> render(ApiWeb.UserView, "user_view.json", %{status: 200, success: true, message: "User retrieved", content: user})
          else
            conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
          end
        else
          conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "User id have to be integer or string type")
        end
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
      end
    end
  end

  def update(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      id = params["userID"]
      if(id !== nil) do
        if (is_bitstring(id) || is_integer(id)) do
          if(is_bitstring(id)) do
            id = String.to_integer(id)
          end
          user = Repo.one(from u in User, where: u.id == ^id)
          if(user !== nil) do
            user
            |> User.changeset(params)
            |> Repo.update()
            conn |> render(ApiWeb.UserView, "user_view.json", %{status: 201, success: true, message: "User updated", content: params})
          else
            conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
          end
        else
          conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "User id have to be integer or string type")
        end
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
      end
    end
  end

  def delete(conn, params) do
    if(conn.assigns == %{}) do
      conn |> render(ApiWeb.ErrorView, "error.json", %{status: 401, error: "Unauthorize"})
    else
      id = params["userID"]
      if(id !== nil) do
        id = String.to_integer(params["userID"])
        user = Repo.one(from u in User, where: u.id == ^id)
        if(user !== nil) do
          newUser = %{ id: user.id, username: user.username, email: user.email}
          Repo.delete(user)
          conn |> render(ApiWeb.UserView, "user_view.json", %{status: 204, success: true, message: "User deleted", content: newUser})
        else
          conn |> render(ApiWeb.ErrorView, "error.json", status: 403, error: "No user found")
        end
      else
        conn |> render(ApiWeb.ErrorView, "error.json", status: 404, error: "Route not found")
      end
    end
  end

end

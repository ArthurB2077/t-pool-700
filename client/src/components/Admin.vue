<template>
  <div class="admin-view-container">
    <div class="admin-view-title-container">
      <div class="greeting-card">
        <h1 class="admin-view-title">Admin View</h1>
      </div>
    </div>

    <div class="admin-view-new-user-container">
      <button
        @click="handleShowNewUserModal(true)"
        class="admin-view-new-user-button"
      >
        <svg viewBox="0 0 457.47 457.469">
          <path
            d="M228.734,0C102.41,0,0,102.41,0,228.735C0,355.06,102.41,457.469,228.734,457.469
            c126.325,0,228.735-102.409,228.735-228.734C457.47,102.41,355.06,0,228.734,0z M359.268,265.476h-97.326v97.315
            c0,16.668-13.506,30.186-30.181,30.186c-16.668,0-30.189-13.518-30.189-30.186v-97.315h-97.309
            c-16.674,0-30.192-13.512-30.192-30.187c0-16.674,13.518-30.188,30.192-30.188h97.315v-97.31c0-16.674,13.515-30.183,30.189-30.183
            c16.675,0,30.187,13.509,30.187,30.183v97.315h97.314c16.669,0,30.192,13.515,30.192,30.188
            C389.46,251.97,375.937,265.476,359.268,265.476z"
          />
        </svg>
        Add user
      </button>
      <div v-if="showNewUserModal" class="admin-view-new-user-modal">
        <div class="admin-view-new-user-modal-form">
          <h5 class="admin-view-new-user-modal-form-title">New user</h5>
          <div class="admin-view-new-user-modal-form-fields">
            <div class="admin-view-new-user-modal-form-field">
              <label for="Username">Username</label>
              <input id="username" type="text" v-model="newUser.username" />
            </div>
            <div class="admin-view-new-user-modal-form-field">
              <label for="email">Email</label>
              <input id="email" type="text" v-model="newUser.email" />
            </div>
            <div class="admin-view-new-user-modal-form-field">
              <label for="password">Password</label>
              <input id="password" type="password" v-model="newUser.password" />
            </div>
          </div>
          <div class="admin-view-new-user-modal-form-buttons">
            <button
              @click="createUser()"
              class="admin-view-new-user-modal-form-create"
            >
              Create
            </button>
            <button
              @click="handleShowNewUserModal(false)"
              class="admin-view-new-user-modal-form-cancel"
            >
              Cancel
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="user-table-container">
      <table>
        <thead>
          <tr>
            <th class="header-id responsive-hide">ID</th>
            <th class="header-primary">Username</th>
            <th class="header-primary responsive-hide">Email</th>
            <th class="header-secondary">Roles</th>
            <th class="header-action responsive-hide">Working times</th>
            <th class="header-action responsive-hide">Action</th>
            <th class="header-action-responsive">Actions</th>
          </tr>
        </thead>
        <tbody v-if="roles.length > 0 && users.length > 0">
          <tr
            v-for="(user, index) in sortUsersByUsername(users)"
            :key="user.id"
          >
            <td class="row-id responsive-hide">{{ user.id }}</td>
            <td class="row-primary">
              <input
                type="text"
                name="username"
                :id="`username-${user.id}`"
                v-model="user.username"
                class=""
              />
            </td>
            <td class="row-primary responsive-hide">
              <input
                type="text"
                name="email"
                :id="`email-${user.id}`"
                v-model="user.email"
              />
            </td>
            <td class="row-secondary">
              <select
                :id="`roles-${user.id}`"
                v-model="selectedUserRoles[index]"
                class=""
              >
                <option
                  v-for="role in roles"
                  v-bind:value="role.id"
                  v-bind:key="role.id"
                >
                  {{ role.role_name }}
                </option>
              </select>
            </td>
            <td class="row-action responsive-hide">
              <RouterLink :to="'/working_times/' + user.id">
                <button class="button-action">Go to</button>
              </RouterLink>
            </td>
            <td class="row-action responsive-hide">
              <button
                class="button-action button-action__green"
                @click="
                  updateUser({ ...user, role_id: selectedUserRoles[index] })
                "
              >
                Save
              </button>
            </td>
            <td class="row-actions-responsive">
              <RouterLink :to="'/working_times/' + user.id">
                <div class="row-actions-responsive-wt">
                  <svg viewBox="0 0 512 512" data-v-cf96b9a6="">
                    <path
                      d="m256 121.538c-72.642 0-131.74 59.099-131.74 131.741s59.099 131.739 131.74 131.739 131.74-59.098 131.74-131.739c0-72.642-59.098-131.741-131.74-131.741zm67.469 146.74h-82.469v-82.468h30v52.469h52.469z"
                      data-v-cf96b9a6=""
                    ></path>
                    <path
                      d="m512 219.617h-52.861l-2.744-11.525c-5.04-21.168-13.394-41.321-24.829-59.902l-6.21-10.091 37.392-37.392-51.455-51.454-37.391 37.392-10.091-6.21c-18.58-11.436-38.734-19.789-59.901-24.829l-11.525-2.744v-52.862h-72.768v52.861l-11.525 2.744c-21.167 5.04-41.321 13.394-59.901 24.829l-10.091 6.21-37.391-37.392-51.454 51.454 37.391 37.392-6.21 10.091c-11.436 18.581-19.79 38.735-24.832 59.903l-2.744 11.525h-52.86v72.766h52.86l2.744 11.525c5.041 21.168 13.396 41.322 24.83 59.902l6.21 10.091-37.391 37.391 51.454 51.454 37.391-37.391 10.091 6.21c18.58 11.436 38.734 19.789 59.901 24.829l11.525 2.744v52.862h72.768v-52.861l11.525-2.744c21.167-5.04 41.321-13.394 59.901-24.829l10.091-6.21 37.391 37.392 51.455-51.455-37.392-37.391 6.21-10.091c11.436-18.581 19.789-38.734 24.829-59.902l2.744-11.525h52.863zm-256 195.402c-89.184 0-161.74-72.556-161.74-161.739 0-89.185 72.557-161.741 161.74-161.741s161.74 72.557 161.74 161.741c0 89.183-72.556 161.739-161.74 161.739z"
                      data-v-cf96b9a6=""
                    ></path>
                  </svg>
                </div>
              </RouterLink>
              <div
                class="row-actions-responsive-save"
                @click="
                  updateUser({ ...user, role_id: selectedUserRoles[index] })
                "
              >
                <svg viewBox="0 0 32 32">
                  <path
                    d="m30.71 7.29-6-6a1 1 0 0 0 -.71-.29h-2v8a2 2 0 0 1 -2 2h-8a2 2 0 0 1 -2-2v-8h-6a3 3 0 0 0 -3 3v24a3 3 0 0 0 3 3h2v-9a3 3 0 0 1 3-3h14a3 3 0 0 1 3 3v9h2a3 3 0 0 0 3-3v-20a1 1 0 0 0 -.29-.71z"
                  />
                  <path d="m12 1h8v8h-8z" />
                  <path d="m23 21h-14a1 1 0 0 0 -1 1v9h16v-9a1 1 0 0 0 -1-1z" />
                </svg>
              </div>
              <div
                class="row-actions-responsive-delete"
                @click="deleteUser(user.id)"
              >
                <svg viewBox="0 0 512 512">
                  <path
                    d="m170.8 14.221a14.21 14.21 0 0 1 14.2-14.207l141.991-.008a14.233 14.233 0 0 1 14.2 14.223v35.117h-170.391zm233.461 477.443a21.75 21.75 0 0 1 -21.856 20.33h-254.451a21.968 21.968 0 0 1 -21.854-20.416l-21.774-318.518h343.174l-23.234 318.6zm56.568-347.452h-409.658v-33a33.035 33.035 0 0 1 33.005-33.012l343.644-.011a33.051 33.051 0 0 1 33 33.02v33zm-270.79 291.851a14.422 14.422 0 1 0 28.844 0v-202.247a14.42 14.42 0 0 0 -28.839-.01v202.257zm102.9 0a14.424 14.424 0 1 0 28.848 0v-202.247a14.422 14.422 0 0 0 -28.843-.01z"
                    fill="#fc0005"
                    fill-rule="evenodd"
                  />
                </svg>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="roles-container">
      <div class="role-table-container">
        <table>
          <thead>
            <tr>
              <th class="header-id responsive-hide">ID</th>
              <th>Label</th>
              <th class="header-icon">Manager status</th>
              <th class="header-icon">Admin status</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="role in roles" :key="role.role_name">
              <td class="row-id responsive-hide">{{ role.id }}</td>
              <td>{{ role.role_name }}</td>
              <td class="row-icon">
                <svg
                  v-if="role.isAuthoriseManager"
                  viewBox="0 0 512 512"
                  width="16px"
                  height="16px"
                >
                  <path
                    d="m256 0c-140.7 0-256 115.3-256 256s115.3 256 256 256 256-115.3 256-256-115.3-256-256-256z"
                    fill="#57d9ad"
                  />
                  <path
                    d="m512 256c0 140.7-115.3 256-256 256v-512c140.7 0 256 115.3 256 256z"
                    fill="#26bfa6"
                  />
                  <path
                    d="m400.3 199.3-144.3 143.999-30 30-114.3-113.999 42.6-42.6 71.7 71.999 30-30 101.7-101.999z"
                    fill="#f2f2f2"
                  />
                  <path
                    d="m400.3 199.3-144.3 143.999v-84.6l101.7-101.999z"
                    fill="#e7e7f2"
                  />
                </svg>
                <svg
                  v-if="!role.isAuthoriseManager"
                  viewBox="0 0 512 512"
                  width="16px"
                  height="16px"
                >
                  <path
                    d="m256 0c-140.7 0-256 115.3-256 256s115.3 256 256 256 256-115.3 256-256-115.3-256-256-256z"
                    fill="#ff7b4a"
                  />
                  <path
                    d="m512 256c0 140.7-115.3 256-256 256v-512c140.7 0 256 115.3 256 256z"
                    fill="#ff435b"
                  />
                  <path
                    d="m298.299 256 74.401 74.099-42.601 42.601-74.099-74.401-74.099 74.401-42.601-42.601 74.401-74.099-74.401-74.101 42.601-42.599 74.099 74.399 74.099-74.399 42.601 42.599z"
                    fill="#f2f2f2"
                  />
                  <path
                    d="m298.299 256 74.401 74.099-42.601 42.601-74.099-74.401v-84.6l74.099-74.399 42.601 42.599z"
                    fill="#e7e7f2"
                  />
                </svg>
              </td>
              <td class="row-icon">
                <svg
                  v-if="role.isAuthoriseAdmin"
                  viewBox="0 0 512 512"
                  width="16px"
                  height="16px"
                >
                  <path
                    d="m256 0c-140.7 0-256 115.3-256 256s115.3 256 256 256 256-115.3 256-256-115.3-256-256-256z"
                    fill="#57d9ad"
                  />
                  <path
                    d="m512 256c0 140.7-115.3 256-256 256v-512c140.7 0 256 115.3 256 256z"
                    fill="#26bfa6"
                  />
                  <path
                    d="m400.3 199.3-144.3 143.999-30 30-114.3-113.999 42.6-42.6 71.7 71.999 30-30 101.7-101.999z"
                    fill="#f2f2f2"
                  />
                  <path
                    d="m400.3 199.3-144.3 143.999v-84.6l101.7-101.999z"
                    fill="#e7e7f2"
                  />
                </svg>
                <svg
                  v-if="!role.isAuthoriseAdmin"
                  viewBox="0 0 512 512"
                  width="16px"
                  height="16px"
                >
                  <path
                    d="m256 0c-140.7 0-256 115.3-256 256s115.3 256 256 256 256-115.3 256-256-115.3-256-256-256z"
                    fill="#ff7b4a"
                  />
                  <path
                    d="m512 256c0 140.7-115.3 256-256 256v-512c140.7 0 256 115.3 256 256z"
                    fill="#ff435b"
                  />
                  <path
                    d="m298.299 256 74.401 74.099-42.601 42.601-74.099-74.401-74.099 74.401-42.601-42.601 74.401-74.099-74.401-74.101 42.601-42.599 74.099 74.399 74.099-74.399 42.601 42.599z"
                    fill="#f2f2f2"
                  />
                  <path
                    d="m298.299 256 74.401 74.099-42.601 42.601-74.099-74.401v-84.6l74.099-74.399 42.601 42.599z"
                    fill="#e7e7f2"
                  />
                </svg>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="role-creation-container">
        <div class="role-creation-field">
          <label for="checkbox">Role name</label>
          <input
            type="text"
            name="role_name"
            id="role_name"
            v-model="newRole.role_name"
            placeholder="New role name"
          />
        </div>
        <div class="role-creation-field">
          <label for="newIsAuthoriseManager">Manager status</label>
          <select
            id="newIsAuthoriseManager"
            v-model="newRole.isAuthoriseManager"
          >
            <option disabled value="">
              Does this role have manager permissions ?
            </option>
            <option>True</option>
            <option>False</option>
          </select>
        </div>
        <div class="role-creation-field">
          <label for="newIsAuthoriseAdmin">Admin status</label>
          <select id="newIsAuthoriseAdmin" v-model="newRole.isAuthoriseAdmin">
            <option disabled value="">
              Does this role have admin permissions ?
            </option>
            <option>True</option>
            <option>False</option>
          </select>
        </div>
        <button class="role-creation-button" @click="createRole()">
          Add role
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { RouterLink } from "vue-router";

export default {
  data() {
    return {
      users: [],
      newUser: {
        username: "",
        email: "",
        password: "",
      },
      showNewUserModal: false,
      selectedUserRoles: [],
      roles: [],
      newRole: {
        role_name: "",
        isAuthoriseManager: "False",
        isAuthoriseAdmin: "False",
      },
    };
  },
  async created() {
    await this.getUsers();
    await this.getRoles();
  },
  methods: {
    getUsers: async function () {
      fetch(process.env.VUE_APP_API_URL + "/users", {
        mode: "cors",
        headers: {
          "Content-type": "application/json; charset=UTF-8",
          Authorization: JSON.parse(localStorage.session).token,
        },
      })
        .then((response) => response.json())
        .then((json) => {
          this.users = json.content;
          this.selectedUserRoles = this.users.map((usr) => usr.role_id);
        });
    },
    createUser: function () {
      const isUserInfoValid = this.checkUserInfos(
        this.newUser.username,
        this.newUser.email,
        this.newUser.password
      );

      if (isUserInfoValid.valid) {
        fetch(process.env.VUE_APP_API_URL + "/register", {
          mode: "cors",
          method: "POST",
          body: JSON.stringify({
            username: this.newUser.username,
            email: this.newUser.email,
            password: this.newUser.password,
          }),
          headers: {
            "Content-type": "application/json; charset=UTF-8",
            Authorization: JSON.parse(localStorage.session).token,
          },
        })
          .then((response) => response.json())
          .then((response) => {
            if (response.success) {
              this.$toast.success("User created !", {
                position: "top-right",
              });
              this.getUsers();
              this.handleShowNewUserModal(false);
            } else if (response && response.error && response.error !== "") {
              this.$toast.error(
                "Something went wrong. " + isUserInfoValid.message,
                {
                  position: "top-right",
                }
              );
            }
          });
      } else {
        this.$toast.error(isUserInfoValid.message, {
          position: "top-right",
        });
      }
    },
    updateUser: async function (user) {
      fetch(process.env.VUE_APP_API_URL + "/users/" + user.id, {
        method: "PUT",
        mode: "cors",
        body: JSON.stringify({
          username: user.username,
          email: user.email,
          role_id: user.role_id,
        }),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
          Authorization: JSON.parse(localStorage.session).token,
        },
      })
        .then((response) => response.json())
        .then((response) => {
          if (response && response.success) {
            this.$toast.success("User updated !", {
              position: "top-right",
            });
            this.getUsers();
          } else if (response && response.error && response.error !== "") {
            this.$toast.error("Something went wrong", {
              position: "top-right",
            });
          } else {
            this.$toast.error("Something went wrong", {
              position: "top-right",
            });
          }
        });
    },
    deleteUser: async function (userId) {
      fetch(process.env.VUE_APP_API_URL + "/users/" + userId, {
        method: "DELETE",
        mode: "cors",
        headers: {
          "Content-type": "application/json; charset=UTF-8",
          Authorization: JSON.parse(localStorage.session).token,
        },
      })
        .then((response) => response.json())
        .then((response) => {
          if (response && response.success) {
            this.$toast.success("User deleted !", {
              position: "top-right",
            });
            this.getUsers();
          } else if (response && response.error && response.error !== "") {
            this.$toast.error("Something went wrong", {
              position: "top-right",
            });
          } else {
            this.$toast.error("Something went wrong", {
              position: "top-right",
            });
          }
        });
    },
    resetNewUser: function () {
      this.newUser = {
        username: "",
        email: "",
        password: "",
      };
    },
    getRoles: async function () {
      fetch(process.env.VUE_APP_API_URL + "/roles", {
        mode: "cors",
        headers: {
          "Content-type": "application/json; charset=UTF-8",
          Authorization: JSON.parse(localStorage.session).token,
        },
      })
        .then((response) => response.json())
        .then((json) => {
          this.roles = json.content;
        });
    },
    createRole: async function () {
      fetch(process.env.VUE_APP_API_URL + "/roles", {
        method: "POST",
        mode: "cors",
        headers: {
          "Content-type": "application/json; charset=UTF-8",
          Authorization: JSON.parse(localStorage.session).token,
        },
        body: JSON.stringify({
          ...this.newRole,
          isAuthoriseManager:
            this.newRole.isAuthoriseManager.toLocaleLowerCase() === "true",
          isAuthoriseAdmin:
            this.newRole.isAuthoriseAdmin.toLocaleLowerCase() === "true",
        }),
      })
        .then((response) => response.json())
        .then(() => {
          this.newRole = {
            role_name: "",
            isAuthoriseManager: "False",
            isAuthoriseAdmin: "False",
          };
          this.getRoles();
        });
    },
    checkUserInfos: function (username, email, password) {
      let isValid = {
        valid: false,
        message: "Invalid informations given",
      };

      if (
        username &&
        email &&
        password &&
        typeof username === "string" &&
        username.length >= 2 &&
        username.length < 16 &&
        typeof email === "string" &&
        email.length > 0 &&
        typeof password === "string" &&
        password.length >= 8 &&
        password.length <= 30
      ) {
        return {
          ...isValid,
          valid: true,
          message: "",
        };
      } else if (username && username.length < 2) {
        return {
          ...isValid,
          message: "Username need to include at least 2 characters",
        };
      } else if (username && username.length >= 16) {
        return {
          ...isValid,
          message: "Username need to includes less than 16 character",
        };
      } else if ((email && email.length <= 0) || !email.includes("@")) {
        return {
          ...isValid,
          message: "Invalid email",
        };
      } else if (password && password.length < 8) {
        return {
          ...isValid,
          message: "Password need to includes at least 8 characters",
        };
      } else if (password && password.length > 30) {
        return {
          ...isValid,
          message: "Password need to includes less than 30 characters",
        };
      } else if (username === undefined) {
        return {
          ...isValid,
          message: "Please provide a no empty username",
        };
      } else if (email === undefined) {
        return {
          ...isValid,
          message: "Please provide a no empty email",
        };
      } else if (password === undefined) {
        return {
          ...isValid,
          message: "Please provide a no empty password",
        };
      } else if (username === "") {
        return {
          ...isValid,
          message: "Please provide a no empty username",
        };
      } else if (email === "") {
        return {
          ...isValid,
          message: "Please provide a no empty email",
        };
      } else if (password === "") {
        return {
          ...isValid,
          message: "Please provide a no empty password",
        };
      } else {
        return {
          ...isValid,
          message:
            "An unexpected error occurred. Please try again or contact your administrator",
        };
      }
    },
    handleShowNewUserModal: function (show) {
      if (!show) {
        this.resetNewUser();
      }
      this.showNewUserModal = show;
    },
    sortUsersByUsername(users) {
      return users.sort((prev, next) => {
        if (prev.username.toLowerCase() < next.username.toLowerCase()) {
          return -1;
        } else if (prev.username.toLowerCase() > next.username.toLowerCase()) {
          return 1;
        } else {
          return 0;
        }
      });
    },
  },
};
</script>

<style scoped lang="scss">
.admin-view-container {
  overflow: auto;
  height: 100%;
  .admin-view-title-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 7vh;
    margin-top: 4vh;
    margin-bottom: 4vh;
    @media screen and (min-width: 150px) and (max-width: 550px) {
      margin-top: 8vh;
      margin-bottom: 8vh;
    }
    .greeting-card {
      width: 25%;
      display: flex;
      justify-content: center;
      background: rgb(170, 111, 207);
      background: linear-gradient(
        45deg,
        rgba(170, 111, 207, 1) 0%,
        rgba(28, 28, 32, 0.2861519607843137) 50%
      );
      padding: 15px;
      border-radius: 15px;
      @media screen and (min-width: 150px) and (max-width: 550px) {
        margin-top: 0;
        width: 95%;
        min-height: 75px;
        padding: 5px;
        border-radius: 10px;
      }
      .admin-view-title {
        color: var(--color-2);
        margin: 0;
        font-size: 24px;
        font-weight: 500;
        @media screen and (min-width: 150px) and (max-width: 550px) {
          font-size: 22px;
          font-weight: 500;
          text-align: center;
          display: flex;
          align-items: center;
        }
      }
    }
  }

  .admin-view-new-user-container {
    margin: 0 10px;
    padding: 0;
    .admin-view-new-user-button {
      border: none;
      border-radius: 20px;
      padding: 7.5px;
      background-color: var(--color-1);
      color: var(--color-2);
      margin-top: 10px;
      width: fit-content;
      height: 40px;
      font-size: 18px;
      font-weight: 400;
      text-align: center;
      color: white;
      margin-right: 10px;
      margin-left: 5px;
      margin-bottom: 15px;
      display: flex;
      align-items: center;
      &:hover {
        filter: brightness(1.25);
        cursor: pointer;
      }
      svg {
        fill: white;
        width: 15px;
        margin-right: 5px;
      }
    }
    .admin-view-new-user-modal {
      position: fixed;
      z-index: 1000;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.75);
      display: table;
      transition: opacity 0.3s ease;
      justify-content: center;
      display: flex;
      align-items: center;
      .admin-view-new-user-modal-form {
        background-color: var(--bg-4);
        padding: 15px;
        border-radius: 10px;
        width: 25vw;
        height: fit-content;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        @media screen and (min-width: 150px) and (max-width: 550px) {
          width: 90vw;
        }
        .admin-view-new-user-modal-form-title {
          color: var(--color-2);
          font-size: 18px;
          margin: 20px 10px;
        }
        .admin-view-new-user-modal-form-fields {
          .admin-view-new-user-modal-form-field {
            label {
              margin: 0 10px;
              font-size: 12px;
            }
            input {
              color: var(--color-2);
              font-size: 18px;
              border-bottom: none;
              margin: 0 10px;
              margin-top: 0;
              margin-bottom: 15px;
              margin-left: 10px;
              margin-right: 10px;
              height: 29px;
              outline: none;
              width: 90%;
              &:hover {
                border-top: none;
                border-left: none;
                border-right: none;
                border-bottom: 1px solid #2eb194;
              }
              &:focus {
                outline: none;
                border-top: none;
                border-left: none;
                border-right: none;
                border-bottom: 1px solid #2eb194;
              }
              &::placeholder {
                filter: brightness(0.85);
              }
            }
          }
        }
        .admin-view-new-user-modal-form-buttons {
          display: flex;
          justify-content: space-between;
          .admin-view-new-user-modal-form-create {
            border: none;
            border-radius: 20px;
            padding: 0 5px;
            background-color: var(--color-4);
            color: var(--color-2);
            width: fit-content;
            width: 90px;
            height: 35px;
            font-size: 18px;
            font-weight: 400;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 10px;
            &:hover {
              filter: brightness(1.25);
              cursor: pointer;
            }
          }
          .admin-view-new-user-modal-form-cancel {
            border: none;
            border-radius: 20px;
            padding: 0 5px;
            background-color: var(--color-3);
            color: var(--color-2);
            width: 90px;
            height: 35px;
            font-size: 18px;
            font-weight: 400;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 10px;
            &:hover {
              filter: brightness(1.25);
              cursor: pointer;
            }
          }
        }
      }
    }
    @media screen and (min-width: 150px) and (max-width: 550px) {
      padding: 0;
      margin: 0 5px;
    }
  }
  .user-table-container {
    color: var(--color-2);
    background-color: var(--bg-4);
    border-radius: 10px;
    padding: 20px;
    margin: 10px;
    @media screen and (min-width: 150px) and (max-width: 550px) {
      padding: 10px;
    }
    table {
      thead {
        tr {
          th {
            padding: 5px;
            font-size: 18px;
            font-weight: 500;
            @media screen and (min-width: 150px) and (max-width: 550px) {
              font-size: 18px;
            }
          }
          .header-id {
            width: 50px;
          }
          .header-primary {
            width: 300px;
            @media screen and (min-width: 150px) and (max-width: 550px) {
              width: auto;
            }
          }
          .header-secondary {
            width: 100px;
            @media screen and (min-width: 150px) and (max-width: 550px) {
              width: auto;
            }
          }
          .header-action {
            width: 200px;
            text-align: center;
            @media screen and (min-width: 150px) and (max-width: 550px) {
              width: 50px !important;
            }
          }
          .header-action-responsive {
            display: none;
            @media screen and (min-width: 150px) and (max-width: 550px) {
              display: table-cell;
              text-align: center;
              width: 90px;
            }
          }
        }
      }
      tbody {
        tr {
          td {
            padding: 5px;
            input[type="text"] {
              color: var(--color-2);
              font-size: 18px;
              border-bottom: none;
              padding: 5px;
              margin: 0;
              height: 29px;
              outline: none;
              &:hover {
                border-top: none;
                border-left: none;
                border-right: none;
                border-bottom: 1px solid #2eb194;
              }
              &:focus {
                outline: none;
                border-top: none;
                border-left: none;
                border-right: none;
                border-bottom: 1px solid #2eb194;
              }
              @media screen and (min-width: 150px) and (max-width: 550px) {
                font-size: 15px;
              }
            }
            select {
              font-size: 18px;
              display: flex;
              background-color: var(--bg-4);
              color: white;
              border: none;
              margin-bottom: 5px;
              padding: 0;
              &:focus {
                outline: none;
                border-bottom: 1px solid #2eb194;
              }
              &:hover {
                border-top: none;
                border-left: none;
                border-right: none;
                border-bottom: 1px solid #2eb194;
              }
              @media screen and (min-width: 150px) and (max-width: 550px) {
                font-size: 15px;
                height: 29px;
                margin-bottom: 0;
              }
            }
            @media screen and (min-width: 150px) and (max-width: 550px) {
              font-size: 15px;
            }
          }
          .row-id {
            width: 50px;
          }
          .row-primary {
            width: 300px;
            @media screen and (min-width: 150px) and (max-width: 550px) {
              width: auto;
            }
          }
          .row-secondary {
            width: 100px;
            @media screen and (min-width: 150px) and (max-width: 550px) {
              width: 100px;
            }
          }
          .row-action {
            width: 200px;
            text-align: center;
            .button-action {
              border: none;
              border-radius: 20px;
              padding: 7.5px;
              background-color: var(--color-1);
              color: var(--color-2);
              width: fit-content;
              width: 90px;
              height: 35px;
              font-size: 18px;
              margin: auto;
              font-weight: 400;
              text-align: center;
              color: white;
              display: flex;
              justify-content: center;
              align-items: center;
              &:hover {
                filter: brightness(1.25);
                cursor: pointer;
              }
              &__green {
                background-color: var(--color-4);
              }
              @media screen and (min-width: 150px) and (max-width: 550px) {
                width: 50px;
                padding: 0;
              }
            }
            @media screen and (min-width: 150px) and (max-width: 550px) {
              width: 50px !important;
              padding: 0;
            }
          }
          .row-actions-responsive {
            display: none;
            @media screen and (min-width: 150px) and (max-width: 550px) {
              display: flex;
              justify-content: center;
              align-items: center;
              width: 90px;
              height: 100%;
              margin-left: 10px;
              .row-actions-responsive-wt {
                margin-top: 10px;
                margin-right: 10px;
                svg {
                  width: 24px;
                  fill: var(--color-1);
                }
              }
              .row-actions-responsive-save {
                margin-top: 10px;
                margin-right: 10px;
                svg {
                  width: 24px;
                  fill: var(--color-4);
                }
              }
              .row-actions-responsive-delete {
                margin-top: 10px;
                svg {
                  width: 24px;
                  fill: var(--color-3);
                }
              }
            }
          }
        }
      }
    }
  }
  .roles-container {
    display: flex;
    justify-content: space-between;
    margin: 10px;
    .role-table-container {
      color: var(--color-2);
      background-color: var(--bg-4);
      border-radius: 10px;
      padding: 20px;
      margin-top: 25px;
      width: 47.5%;
      table {
        thead {
          tr {
            th {
              font-size: 18px;
              font-weight: 500;
            }
            .header-id {
              width: 100px;
            }
            .header-icon {
              text-align: center;
            }
          }
        }
        tbody {
          tr {
            td {
              font-size: 18px;
            }
            .row-icon {
              text-align: center;
            }
            .row-id {
              width: 100px;
            }
          }
        }
      }
      @media screen and (min-width: 150px) and (max-width: 550px) {
        width: 100%;
        margin: auto;
        margin-top: 50px;
      }
    }
    .role-creation-container {
      color: var(--color-2);
      background-color: var(--bg-4);
      border-radius: 10px;
      padding: 20px;
      margin-top: 35px;
      width: 47.5%;
      .role-creation-field {
        input[type="text"] {
          color: var(--color-2);
          font-size: 18px;
          border-bottom: none;
          margin-top: 0;
          margin-right: 0;
          margin-left: 0;
          margin-bottom: 20px;
          height: 29px;
          outline: none;
          padding-top: 0;
          padding-bottom: 7px;
          padding-right: 0;
          padding-left: 2px;
          &:hover {
            border-top: none;
            border-left: none;
            border-right: none;
            border-bottom: 1px solid #2eb194;
          }
          &:focus {
            outline: none;
            border-top: none;
            border-left: none;
            border-right: none;
            border-bottom: 1px solid #2eb194;
          }
          &::placeholder {
            filter: brightness(0.85);
          }
        }
        label {
          font-size: 18px;
          font-weight: 500;
          color: var(--color-2);
        }
        select {
          display: flex;
          background-color: var(--bg-4);
          color: var(--color-2);
          border: none;
          margin-bottom: 15px;
          padding: 0;
          color: var(--color-2);
          font-size: 18px;
          &:focus {
            outline: none;
            border-bottom: 1px solid #2eb194;
          }
          &:hover {
            border-top: none;
            border-left: none;
            border-right: none;
            border-bottom: 1px solid #2eb194;
          }
        }
      }
      .role-creation-button {
        border: none;
        border-radius: 20px;
        padding: 7.5px;
        background-color: var(--color-4);
        color: var(--color-2);
        margin-top: 10px;
        width: 100px;
        height: 35px;
        font-size: 18px;
        font-weight: 400;
        text-align: center;
        color: white;
        margin-right: 10px;
        margin-bottom: 15px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-left: calc(50% - 50px);
        &:hover {
          filter: brightness(1.25);
          cursor: pointer;
        }
      }
      @media screen and (min-width: 150px) and (max-width: 550px) {
        width: 100%;
        margin: auto;
        margin-top: 50px;
        margin-bottom: 25px;
      }
    }

    @media screen and (min-width: 150px) and (max-width: 550px) {
      flex-direction: column;
    }
  }
}
.responsive-hide {
  @media screen and (min-width: 150px) and (max-width: 550px) {
    display: none;
  }
}
</style>

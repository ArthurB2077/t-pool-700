<template>
  <div class="mv-container">
    <div class="mv-title-container">
      <div class="mv-greeting-card">
        <h1 class="mv-title">Manager View</h1>
      </div>
    </div>

    <div class="mv-new-team-container">
      <button @click="handleShowNewTeamModal(true)" class="mv-new-team-button">
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
        Add team
      </button>
      <div v-if="showNewTeamModal" class="mv-new-team-modal">
        <div class="mv-new-team-modal-form">
          <h3 class="mv-new-team-modal-form-title">
            Enter a name for your team:
          </h3>
          <input type="text" v-model="newteam" placeholder="New team" />
          <div class="mv-new-team-modal-form-buttons">
            <button @click="addTeam()" class="mv-new-team-modal-form-create">
              Create
            </button>
            <button
              @click="handleShowNewTeamModal(false, true)"
              class="mv-new-team-modal-form-cancel"
            >
              Cancel
            </button>
          </div>
        </div>
      </div>
    </div>

    <div
      v-for="team in sortMembersOfTeam(teams)"
      :key="team.id"
      class="mv-team-accordion"
    >
      <div class="mv-accordion-header">
        <h2 class="mv-team-name">{{ team.team_name }}</h2>
        <RouterLink :to="{ path: `/chart_managerTeam/${team.id}` }">
          <button class="mv-team-charts-link">
            <svg viewBox="0 0 323.97 323.97">
              <path
                d="M315.062,175.001h-112.28c-4.907,0-8.907,4-8.907,8.906c0,2.499,1.062,4.75,2.718,6.374l79.062,79.062
                c1.624,1.75,3.97,2.845,6.533,2.845c3.093,0,5.811-1.563,7.405-3.938c19.438-22.563,31.938-51.219,34.189-82.75
                c0.125-0.531,0.187-1.062,0.187-1.594C323.97,179.001,320,175.001,315.062,175.001z"
              />
              <path
                d="M168.875,13.594c-4.907,0.03-8.875,4-8.875,8.906v124.781c0,4.938,3.968,8.938,8.875,8.938h124.813
                c4.907,0,8.906-4,8.906-8.938C298.187,75.47,240.718,18.001,168.875,13.594z"
              />
              <path
                d="M237.469,262.063l-92.062-92.062c-1.562-1.594-2.499-3.813-2.499-6.219L142.875,33.75c0-4.906-3.968-8.875-8.875-8.875
                C59.219,29.438,0,91.562,0,167.47c0,78.906,63.97,142.906,142.875,142.906c36,0,68.875-13.312,94-35.282
                c1.938-1.626,3.157-4.062,3.157-6.781C240.032,265.906,239.062,263.687,237.469,262.063z"
              />
            </svg>
            Charts
          </button>
        </RouterLink>
      </div>
      <div class="mv-accordion-content">
        <table class="mv-team-member-table">
          <thead class="mv-team-member-header">
            <tr class="mv-team-member-header-row">
              <th class="mv-team-member-header-cell responsive-hide">
                Username
              </th>
              <th class="mv-team-member-header-cell">Email</th>
              <th class="mv-team-member-header-cell">Role</th>
              <th
                class="mv-team-member-header-cell mv-team-member-header-cell__action responsive-hide"
              >
                User working times
              </th>
              <th
                class="mv-team-member-header-cell mv-team-member-header-cell__action responsive-hide"
              >
                User dashboard
              </th>
              <th
                class="mv-team-member-header-cell mv-team-member-header-cell__action responsive-hide"
              >
                Actions
              </th>
              <th
                class="mv-team-member-header-cell mv-team-member-header-cell__action responsive-active"
              >
                Actions
              </th>
            </tr>
          </thead>
          <tbody class="mv-team-member-body">
            <tr
              v-for="member in team.members"
              :key="member.id"
              class="mv-team-member-body-row"
            >
              <td class="mv-team-member-body-cell responsive-hide">
                {{ member.username }}
              </td>
              <td class="mv-team-member-body-cell">{{ member.email }}</td>
              <td class="mv-team-member-body-cell">
                {{ findRoleNameById(member.role_id) }}
              </td>
              <td
                class="mv-team-member-body-cell mv-team-member-body-cell__action responsive-hide"
              >
                <RouterLink :to="'/working_times/' + member.id">
                  <button class="mv-team-member-body-link">Go to</button>
                </RouterLink>
              </td>
              <td
                class="mv-team-member-body-cell mv-team-member-body-cell__action responsive-hide"
              >
                <RouterLink :to="'/chart_manager/' + member.id">
                  <button class="mv-team-member-body-link">Go to</button>
                </RouterLink>
              </td>
              <td
                class="mv-team-member-body-cell mv-team-member-body-cell__action responsive-hide"
              >
                <button
                  @click="deleteInTeam(member.id, team.id)"
                  class="mv-team-member-body-delete"
                >
                  Remove
                </button>
              </td>
              <td
                class="mv-team-member-body-cell-mobile-actions responsive-active"
              >
                <RouterLink :to="'/working_times/' + member.id">
                  <div class="mv-team-member-body-cell-icon-container">
                    <svg viewBox="0 0 512 512">
                      <path
                        d="m256 121.538c-72.642 0-131.74 59.099-131.74 131.741s59.099 131.739 131.74 131.739 131.74-59.098 131.74-131.739c0-72.642-59.098-131.741-131.74-131.741zm67.469 146.74h-82.469v-82.468h30v52.469h52.469z"
                      />
                      <path
                        d="m512 219.617h-52.861l-2.744-11.525c-5.04-21.168-13.394-41.321-24.829-59.902l-6.21-10.091 37.392-37.392-51.455-51.454-37.391 37.392-10.091-6.21c-18.58-11.436-38.734-19.789-59.901-24.829l-11.525-2.744v-52.862h-72.768v52.861l-11.525 2.744c-21.167 5.04-41.321 13.394-59.901 24.829l-10.091 6.21-37.391-37.392-51.454 51.454 37.391 37.392-6.21 10.091c-11.436 18.581-19.79 38.735-24.832 59.903l-2.744 11.525h-52.86v72.766h52.86l2.744 11.525c5.041 21.168 13.396 41.322 24.83 59.902l6.21 10.091-37.391 37.391 51.454 51.454 37.391-37.391 10.091 6.21c18.58 11.436 38.734 19.789 59.901 24.829l11.525 2.744v52.862h72.768v-52.861l11.525-2.744c21.167-5.04 41.321-13.394 59.901-24.829l10.091-6.21 37.391 37.392 51.455-51.455-37.392-37.391 6.21-10.091c11.436-18.581 19.789-38.734 24.829-59.902l2.744-11.525h52.863zm-256 195.402c-89.184 0-161.74-72.556-161.74-161.739 0-89.185 72.557-161.741 161.74-161.741s161.74 72.557 161.74 161.741c0 89.183-72.556 161.739-161.74 161.739z"
                      />
                    </svg>
                  </div>
                </RouterLink>
                <RouterLink :to="'/chart_manager/' + member.id">
                  <div class="mv-team-member-body-cell-icon-container">
                    <svg viewBox="0 0 323.97 323.97">
                      <path
                        d="M315.062,175.001h-112.28c-4.907,0-8.907,4-8.907,8.906c0,2.499,1.062,4.75,2.718,6.374l79.062,79.062
                        c1.624,1.75,3.97,2.845,6.533,2.845c3.093,0,5.811-1.563,7.405-3.938c19.438-22.563,31.938-51.219,34.189-82.75
                        c0.125-0.531,0.187-1.062,0.187-1.594C323.97,179.001,320,175.001,315.062,175.001z"
                      />
                      <path
                        d="M168.875,13.594c-4.907,0.03-8.875,4-8.875,8.906v124.781c0,4.938,3.968,8.938,8.875,8.938h124.813
                        c4.907,0,8.906-4,8.906-8.938C298.187,75.47,240.718,18.001,168.875,13.594z"
                      />
                      <path
                        d="M237.469,262.063l-92.062-92.062c-1.562-1.594-2.499-3.813-2.499-6.219L142.875,33.75c0-4.906-3.968-8.875-8.875-8.875
                        C59.219,29.438,0,91.562,0,167.47c0,78.906,63.97,142.906,142.875,142.906c36,0,68.875-13.312,94-35.282
                        c1.938-1.626,3.157-4.062,3.157-6.781C240.032,265.906,239.062,263.687,237.469,262.063z"
                      />
                    </svg>
                  </div>
                </RouterLink>
                <div
                  @click="deleteInTeam(member.id, team.id)"
                  class="mv-team-member-body-cell-icon-container mv-team-member-body-cell-icon-container__remove"
                >
                  <svg viewBox="0 0 32 32">
                    <path
                      d="m19.72 31h-17.72a1 1 0 0 1 -1-1v-2a12.993 12.993 0 0 1 6.61-11.31 10 10 0 0 0 12.8-.01 11.475 11.475 0 0 1 1.46.96 7.989 7.989 0 0 0 -2.15 13.36z"
                    />
                    <circle cx="14" cy="9" r="8" />
                    <path
                      d="m25 19a5.94 5.94 0 0 0 -2.126.386 6.007 6.007 0 1 0 2.126-.386zm2 7h-4a1 1 0 0 1 0-2h4a1 1 0 0 1 0 2z"
                    />
                  </svg>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
        <div class="mv-team-member-new-member-row">
          <div
            @click="handleShowNewUserModal(true, team.id)"
            class="mv-team-member-new-member-cell"
          >
            <svg viewBox="0 0 24 24">
              <path
                d="m15 7c0 .90058-.2222 1.73684-.6667 2.50877-.4444.76023-1.0526 1.36843-1.8245 1.82453-.7603.4445-1.5965.6667-2.5088.6667-.90058 0-1.73684-.2222-2.50877-.6667-.76024-.4561-1.36842-1.0643-1.82456-1.82453-.44445-.76023-.66667-1.59649-.66667-2.50877s.22222-1.74854.66667-2.50877c.45614-.77193 1.06432-1.38012 1.82456-1.82456.76023-.44445 1.59649-.66667 2.50877-.66667.9123 0 1.7485.22222 2.5088.66667.7719.44444 1.3801 1.05263 1.8245 1.82456.4445.76023.6667 1.59649.6667 2.50877zm-5 6c1.6023 0 3.0877.2105 4.4561.6316 1.3802.421 2.4796 1.0117 3.2983 1.7719.8304.7602 1.2456 1.6257 1.2456 2.5965 0 .7135-.1813 1.3801-.5439 2-.3508.6082-.8362 1.0936-1.4561 1.4561-.6082.3626-1.2749.5439-2 .5439h-10c-.72515 0-1.39181-.1813-2-.5439-.60819-.3625-1.09357-.8479-1.45614-1.4561s-.54386-1.2749-.54386-2c0-.9708.40936-1.8363 1.22807-2.5965.83041-.7602 1.92982-1.3509 3.29825-1.7719 1.38011-.4211 2.87134-.6316 4.47368-.6316zm8-5c0-.2807.0994-.51462.2982-.70176.1989-.19882.4328-.29824.7018-.29824.2807 0 .5146.09942.7018.29824.1988.18714.2982.42106.2982.70176v6c0 .269-.0994.5029-.2982.7018-.1872.1988-.4211.2982-.7018.2982-.269 0-.5029-.0994-.7018-.2982-.1988-.1989-.2982-.4328-.2982-.7018zm-2 4c-.269 0-.5029-.0994-.7018-.2982-.1988-.1989-.2982-.4328-.2982-.7018 0-.2807.0994-.5146.2982-.7018.1989-.1988.4328-.2982.7018-.2982h6c.2807 0 .5146.0994.7018.2982.1988.1872.2982.4211.2982.7018 0 .269-.0994.5029-.2982.7018-.1872.1988-.4211.2982-.7018.2982z"
              />
            </svg>
          </div>
        </div>
      </div>
    </div>

    <div v-if="showNewUserModal" class="mv-modal-add-user-mask">
      <div class="mv-modal-add-header">
        <div class="mv-modal-title-container">
          <h3 class="mv-modal-title">User list</h3>
        </div>
        <div @click="handleShowNewUserModal(false)" class="mv-modal-close-box">
          <svg viewBox="0 0 492 492">
            <path
              d="M300.188,246L484.14,62.04c5.06-5.064,7.852-11.82,7.86-19.024c0-7.208-2.792-13.972-7.86-19.028L468.02,7.872
              c-5.068-5.076-11.824-7.856-19.036-7.856c-7.2,0-13.956,2.78-19.024,7.856L246.008,191.82L62.048,7.872
              c-5.06-5.076-11.82-7.856-19.028-7.856c-7.2,0-13.96,2.78-19.02,7.856L7.872,23.988c-10.496,10.496-10.496,27.568,0,38.052
              L191.828,246L7.872,429.952c-5.064,5.072-7.852,11.828-7.852,19.032c0,7.204,2.788,13.96,7.852,19.028l16.124,16.116
              c5.06,5.072,11.824,7.856,19.02,7.856c7.208,0,13.968-2.784,19.028-7.856l183.96-183.952l183.952,183.952
              c5.068,5.072,11.824,7.856,19.024,7.856h0.008c7.204,0,13.96-2.784,19.028-7.856l16.12-16.116
              c5.06-5.064,7.852-11.824,7.852-19.028c0-7.204-2.792-13.96-7.852-19.028L300.188,246z"
            />
          </svg>
        </div>
      </div>
      <div class="mv-modal-add-user">
        <table class="mv-modal-add-user-table">
          <thead class="mv-modal-add-user-header">
            <tr class="mv-modal-add-user-header-row">
              <th class="mv-modal-add-user-header-cell responsive-hide">
                Username
              </th>
              <th class="mv-modal-add-user-header-cell">Email</th>
              <th class="mv-modal-add-user-header-cell">Role</th>
              <th
                class="mv-modal-add-user-header-cell mv-modal-add-user-header-cell__action"
              >
                Actions
              </th>
            </tr>
          </thead>
          <tbody class="mv-modal-add-user-body">
            <tr
              v-for="user in filteredBySelectedTeamUsers"
              :key="user.id"
              class="mv-modal-add-user-body-row"
            >
              <td class="mv-modal-add-user-body-cell responsive-hide">
                {{ user.username }}
              </td>
              <td class="mv-modal-add-user-body-cell">{{ user.email }}</td>
              <td class="mv-modal-add-user-body-cell">
                {{ findRoleNameById(user.role_id) }}
              </td>
              <td
                class="mv-modal-add-user-body-cell mv-modal-add-user-body-cell__action"
              >
                <button
                  @click="addMemberInTeam(user.id, teamToAdd)"
                  class="mv-modal-add-user-body-add responsive-hide"
                >
                  Add
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import User from "../api/User.js";

export default {
  data() {
    return {
      session: {
        active: false,
        id: null,
        username: "",
        email: "",
      },
      newteam: "",
      teamToAdd: null,
      teams: [],
      filteredBySelectedTeamUsers: [],
      users: [],
      roles: [],
      showNewTeamModal: false,
      showNewUserModal: false,
    };
  },
  async created() {
    this.session = JSON.parse(localStorage.session);
    this.getTeams();
    this.getUsers();
    this.getRoles();
  },
  methods: {
    getTeams: async function () {
      const teams = await User.getUserTeams(this.session.id);

      if (teams) {
        if (teams.success && teams.content.length > 0) {
          this.teams = teams.content;
        } else {
          this.$toast.error(teams.error, {
            position: "top-right",
          });
        }
      } else {
        this.$toast.error("Something went wrong while retrieving teams", {
          position: "top-right",
        });
      }
    },
    getUsers: async function () {
      const users = await User.getAllUsers();

      if (users) {
        if (users.success && users.content.length > 0) {
          this.users = users.content;
        } else {
          this.$toast.error(users.error, {
            position: "top-right",
          });
        }
      } else {
        this.$toast.error("Something went wrong while retrieving teams", {
          position: "top-right",
        });
      }
    },
    getRoles: async function () {
      const roles = await User.getRoles();

      if (roles) {
        if (roles.success && roles.content.length > 0) {
          this.roles = roles.content;
        } else {
          this.$toast.error(roles.error, {
            position: "top-right",
          });
        }
      } else {
        this.$toast.error("Something went wrong while retrieving teams", {
          position: "top-right",
        });
      }
    },
    addTeam: async function () {
      if (this.newteam && this.newteam !== "") {
        const response = await User.createTeam(this.session.id, this.newteam);
        if (response.success) {
          this.handleShowNewTeamModal(false, true);
          this.$toast.success(response.message, {
            position: "top-right",
          });
        } else {
          this.$toast.error(response.error, {
            position: "top-right",
          });
        }
        await this.getTeams();
      } else {
        this.$toast.error("Please provide a not empty name", {
          position: "top-right",
        });
      }
    },
    addMemberInTeam: async function (user_id, team_id) {
      const response = await User.addMemberInTeam(user_id, team_id);
      if (response.success) {
        this.$toast.success(response.message, {
          position: "top-right",
        });
        await this.getTeams();
        await this.getUsers();
        this.filteredBySelectedTeamUsers = this.users.filter(
          (user) => !user.teams.map((team) => team.id).includes(team_id)
        );
      } else {
        this.$toast.error(response.error, {
          position: "top-right",
        });
      }
    },
    deleteInTeam: async function (user_id, team_id) {
      const response = await User.deleteUserInTeam(user_id, team_id);
      if (response.success) {
        this.$toast.success(response.message, {
          position: "top-right",
        });
        await this.getTeams();
        await this.getUsers();
        this.filteredBySelectedTeamUsers = this.users.filter(
          (user) => !user.teams.map((team) => team.id).includes(team_id)
        );
      } else {
        this.$toast.error(response.error, {
          position: "top-right",
        });
      }
      await this.getTeams();
    },
    findRoleNameById: function (roleId) {
      if (this.roles && this.roles.length > 0) {
        const role = this.roles.find((rl) => rl.id === roleId);
        if (role) {
          return role.role_name;
        } else {
          return "";
        }
      } else {
        return "";
      }
    },
    handleShowNewTeamModal: function (show, cleanFields) {
      if (cleanFields) {
        this.newteam = "";
      }
      this.showNewTeamModal = show;
    },
    handleShowNewUserModal: function (show, teamId = null) {
      if (teamId) {
        this.teamToAdd = teamId;
        this.filteredBySelectedTeamUsers = this.users.filter(
          (user) => !user.teams.map((team) => team.id).includes(teamId)
        );
      }
      this.showNewUserModal = show;
    },
    sortMembersOfTeam(teams) {
      return teams.map((team) => {
        if (team.members && team.members.length > 0) {
          return {
            ...team,
            members: team.members.sort((prev, next) => {
              if (prev.username.toLowerCase() < next.username.toLowerCase()) {
                return -1;
              } else if (
                prev.username.toLowerCase() > next.username.toLowerCase()
              ) {
                return 1;
              } else {
                return 0;
              }
            }),
          };
        } else {
          return team;
        }
      });
    },
  },
};
</script>

<style scoped lang="scss">
.mv-container {
  overflow: auto;
  height: 100%;
  width: 100%;
  .mv-title-container {
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
    .mv-greeting-card {
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
      .mv-title {
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
  .mv-new-team-container {
    margin: 0 10px;
    padding: 0 20px;
    .mv-new-team-button {
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
      margin-bottom: 15px;
      display: flex;
      align-items: center;
      &:hover {
        filter: brightness(1.25);
        cursor: pointer;
      }
      svg {
        fill: white;
        width: 18px;
        margin-right: 5px;
      }
    }
    .mv-new-team-modal {
      position: fixed;
      z-index: 1000;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.75);
      transition: opacity 0.3s ease;
      justify-content: center;
      display: flex;
      align-items: center;
      .mv-new-team-modal-form {
        background-color: var(--bg-4);
        padding: 15px;
        border-radius: 10px;
        width: 25vw;
        height: 12.5vw;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        @media screen and (min-width: 150px) and (max-width: 550px) {
          width: 90vw;
          height: fit-content;
        }
        .mv-new-team-modal-form-title {
          color: var(--color-2);
          font-size: 18px;
          margin: 10px;
        }
        input[type="text"] {
          color: var(--color-2);
          font-size: 18px;
          border-bottom: none;
          margin: 10px;
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
        .mv-new-team-modal-form-buttons {
          display: flex;
          justify-content: space-between;
          .mv-new-team-modal-form-create {
            border: none;
            border-radius: 20px;
            padding: 0 5px;
            background-color: var(--color-4);
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
          .mv-new-team-modal-form-cancel {
            border: none;
            border-radius: 20px;
            padding: 0 5px;
            background-color: var(--color-3);
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
        }
      }
    }
    @media screen and (min-width: 150px) and (max-width: 550px) {
      padding: 0;
      margin-bottom: 0;
    }
  }
  .mv-team-accordion {
    padding: 20px;
    margin: 10px;
    .mv-accordion-header {
      height: 5em;
      background-color: var(--bg-4);
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
      display: flex;
      align-items: center;
      padding: 20px;
      justify-content: space-between;
      .mv-team-name {
        color: var(--color-2);
        font-size: 18px;
        font-weight: 500;
        margin: 0;
        width: fit-content;
      }
      .mv-team-charts-link {
        border: none;
        border-radius: 20px;
        padding: 0 10px;
        background-color: var(--color-1);
        color: var(--color-2);
        width: fit-content;
        width: 100px;
        height: 35px;
        font-size: 18px;
        font-weight: 400;
        text-align: center;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-right: 10px;
        &:hover {
          filter: brightness(1.25);
          cursor: pointer;
        }
        svg {
          fill: var(--color-2);
          width: 18px;
          margin-right: 5px;
        }
      }
      @media screen and (min-width: 150px) and (max-width: 550px) {
        padding: 10px;
      }
    }
    .mv-accordion-content {
      background-color: var(--bg-1);
      padding: 10px 15px;
      border-bottom-left-radius: 10px;
      border-bottom-right-radius: 10px;
      .mv-team-member-table {
        .mv-team-member-header {
          .mv-team-member-header-row {
            .mv-team-member-header-cell {
              color: var(--color-2);
              font-size: 18px;
              font-weight: 500;
              &__action {
                text-align: center;
              }
            }
          }
        }
        .mv-team-member-body {
          .mv-team-member-body-row {
            .mv-team-member-body-cell {
              color: var(--color-2);
              font-size: 18px;
              &__action {
                text-align: center;
              }
              .mv-team-member-body-link {
                border: none;
                border-radius: 20px;
                padding: 0 5px;
                background-color: var(--color-1);
                color: var(--color-2);
                width: 80px;
                height: 35px;
                font-size: 18px;
                font-weight: 400;
                text-align: center;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: auto;
                &:hover {
                  filter: brightness(1.25);
                  cursor: pointer;
                }
              }
              .mv-team-member-body-delete {
                border: none;
                border-radius: 20px;
                padding: 0 5px;
                background-color: var(--color-3);
                color: var(--color-2);
                width: 80px;
                height: 35px;
                font-size: 18px;
                font-weight: 400;
                text-align: center;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: auto;
                &:hover {
                  filter: brightness(1.25);
                  cursor: pointer;
                }
              }
              @media screen and (min-width: 150px) and (max-width: 550px) {
                font-size: 15px;
              }
            }
            .mv-team-member-body-cell-mobile-actions {
              display: flex;
              justify-content: space-between;
              .mv-team-member-body-cell-icon-container {
                svg {
                  width: 24px;
                  fill: var(--color-1);
                }
                &__remove {
                  svg {
                    fill: var(--color-3);
                  }
                }
              }
              @media screen and (min-width: 551px) {
                display: none;
              }
            }
          }
        }
      }
      @media screen and (min-width: 150px) and (max-width: 550px) {
        padding: 5px;
      }
    }
    .mv-team-member-new-member-row {
      height: 60px;
      width: 100% !important;
      display: flex;
      justify-content: center;
      align-items: center;
      .mv-team-member-new-member-cell {
        width: fit-content;
        height: fit-content;
        svg {
          fill: var(--color-1);
          width: 36px;
          &:hover {
            filter: brightness(1.5);
            cursor: pointer;
          }
          @media screen and (min-width: 150px) and (max-width: 550px) {
            width: 28px;
          }
        }
      }
    }
    @media screen and (min-width: 150px) and (max-width: 550px) {
      padding: 0;
      margin-left: 10px;
      margin-right: 10px;
      margin-bottom: 8vh;
    }
  }
  .mv-modal-add-user-mask {
    position: fixed;
    z-index: 1000;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.75);
    transition: opacity 0.3s ease;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    .mv-modal-add-header {
      background-color: var(--bg-3);
      width: 50%;
      height: 75px;
      border-top-left-radius: 10px;
      border-top-right-radius: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      .mv-modal-title-container {
        .mv-modal-title {
          color: var(--color-2);
          font-size: 16px;
          font-weight: 500;
          margin: 0;
          padding-left: 25px;
        }
      }
      .mv-modal-close-box {
        width: 36px;
        height: 36px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        svg {
          fill: var(--color-2);
          width: 18px;
        }
        &:hover {
          cursor: pointer;
          svg {
            fill: var(--color-1);
          }
        }
      }
      @media screen and (min-width: 150px) and (max-width: 550px) {
        width: 95%;
      }
    }
    .mv-modal-add-user {
      background-color: var(--bg-4);
      padding: 25px;
      border-bottom-left-radius: 10px;
      border-bottom-right-radius: 10px;
      overflow: auto;
      max-height: 70%;
      width: 50%;
      .mv-modal-add-user-table {
        .mv-modal-add-user-header {
          .mv-modal-add-user-header-row {
            .mv-modal-add-user-header-cell {
              color: var(--color-2);
              font-size: 14px;
              font-weight: 500;
              &__action {
                text-align: center;
              }
            }
          }
        }
        .mv-modal-add-user-body {
          .mv-modal-add-user-body-row {
            .mv-modal-add-user-body-cell {
              color: var(--color-2);
              font-size: 14px;
              &__action {
                text-align: center;
              }
              .mv-modal-add-user-body-add {
                border: none;
                border-radius: 15px;
                padding: 0 5px;
                background-color: var(--color-4);
                color: var(--color-2);
                width: fit-content;
                min-width: 60px;
                height: 25px;
                font-size: 12px;
                font-weight: 400;
                text-align: center;
                display: flex;
                justify-content: center;
                align-items: center;
                margin: auto;
                &:hover {
                  filter: brightness(1.25);
                  cursor: pointer;
                }
              }
            }
          }
        }
      }
      @media screen and (min-width: 150px) and (max-width: 550px) {
        width: 95%;
      }
    }
  }
}
.responsive-hide {
  @media screen and (min-width: 150px) and (max-width: 550px) {
    display: none;
  }
}
.responsive-active {
  display: none;
  @media screen and (min-width: 150px) and (max-width: 550px) {
    display: block;
  }
}
</style>

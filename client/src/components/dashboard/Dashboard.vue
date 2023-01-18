<template>
  <div class="dashboard-container">
    <div class="menu-title-container">
      <div class="greeting-card">
        <h1 class="menu-title">Dashboard</h1>
      </div>
    </div>
    <div class="nav-dashboard" v-if="path !== '' && idToGo !== -1">
      <router-link :to="{ path: `/${path}/${idToGo}` }">
        <button class="nav-link-dashboard">All</button>
      </router-link>
      <router-link :to="{ path: `/${path}/${idToGo}/bar` }">
        <button class="nav-link-dashboard">Week</button>
      </router-link>
      <router-link :to="{ path: `/${path}/${idToGo}/line` }">
        <button class="nav-link-dashboard">Year</button>
      </router-link>
      <router-link :to="{ path: `/${path}/${idToGo}/doughnut` }">
        <button class="nav-link-dashboard">Day</button>
      </router-link>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      userID: JSON.parse(localStorage.session).id,
      user: false,
      team: false,
      path: "",
      idToGo: -1,
    };
  },
  mounted() {
    this.getFunction();
  },
  methods: {
    getFunction: function () {
      const userID = this.$route.params.userID;
      const teamID = this.$route.params.teamID;
      if (userID !== undefined) {
        this.path = "chart_manager";
        this.idToGo = userID;
      } else {
        this.path = "chart_managerTeam";
        this.idToGo = teamID;
      }
    },
  },
};
</script>

<style scoped lang="scss">
.dashboard-container {
  overflow: auto;
  max-height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  .menu-title-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 10%;
    margin-top: 2.5%;
    margin-bottom: 2.5%;

    @media screen and (min-width: 150px) and (max-width: 1300px) {
      margin-top: 10%;
      margin-bottom: 10%;
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

      @media screen and (min-width: 150px) and (max-width: 1300px) {
        margin-top: 0;
        width: 95%;
        min-height: 75px;
        padding: 5px;
        border-radius: 10px;
      }

      .menu-title {
        color: var(--color-2);
        margin: 0;
        font-size: 24px;
        font-weight: 500;

        @media screen and (min-width: 150px) and (max-width: 1300px) {
          font-size: 22px;
          font-weight: 500;
          text-align: center;
          display: flex;
          align-items: center;
        }
      }
    }
  }

  .nav-dashboard {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 25px;
    margin-bottom: 2.5%;
    @media screen and (min-width: 150px) and (max-width: 1300px) {
      margin-top: 0;
      margin-left: auto;
      margin-right: auto;
      width: 95%;
      justify-content: space-between;
      margin-bottom: 10%;
    }

    .nav-link-dashboard {
      border: none;
      border-radius: 15px;
      padding: 5px;
      background-color: var(--color-1);
      color: var(--color-2);
      margin-top: 10px;
      width: 90px;
      height: 35px;
      font-size: 18px;
      font-weight: 400;
      text-align: center;
      color: white;
      margin-right: 10px;

      &:hover {
        filter: brightness(1.25);
        cursor: pointer;
      }

      @media screen and (min-width: 150px) and (max-width: 1300px) {
        width: 75px;
        margin-right: 0;
      }
    }
  }

  @media screen and (min-width: 150px) and (max-width: 1300px) {
    overflow-x: hidden;
    display: inherit;
    flex-direction: inherit;
    justify-content: inherit;
    align-items: inherit;
  }
}
</style>

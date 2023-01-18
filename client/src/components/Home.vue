<script setup>
import { RouterLink } from "vue-router";
</script>

<template>
  <div class="homepage">
    <div class="menu-title-container">
      <div class="greeting-card">
        <h1 class="menu-title">Welcome {{ session.username }} !</h1>
      </div>
    </div>

    <div class="card-menu-container">
      <div class="card-menu">
        <h2 class="card-menu-title">Clock</h2>
        <p class="card-menu-description">
          Start or end a clock to set-up your working times
        </p>
        <p class="card-menu-description">
          {{ hours }} : {{ minutes }} : {{ seconds }}
        </p>
        <p class="card-menu-description" v-if="clock.status">
          {{ stopWatch.hours }} : {{ stopWatch.minutes }} :
          {{ stopWatch.seconds }}
        </p>
        <button
          class="card-menu-button"
          v-if="!clock.status"
          @click="startClock('start')"
        >
          Start Clock
        </button>
        <button
          class="card-menu-button"
          v-if="clock.status"
          @click="startClock('end')"
        >
          End Clock
        </button>
      </div>

      <div class="card-menu">
        <h2 class="card-menu-title">Working times</h2>
        <p class="card-menu-description">View and manage your working times</p>
        <div class="card-menu-icon">
          <svg viewBox="0 0 512 512">
            <g>
              <path
                d="m256 121.538c-72.642 0-131.74 59.099-131.74 131.741s59.099 131.739 131.74 131.739 131.74-59.098 131.74-131.739c0-72.642-59.098-131.741-131.74-131.741zm67.469 146.74h-82.469v-82.468h30v52.469h52.469z"
              />
              <path
                d="m512 219.617h-52.861l-2.744-11.525c-5.04-21.168-13.394-41.321-24.829-59.902l-6.21-10.091 37.392-37.392-51.455-51.454-37.391 37.392-10.091-6.21c-18.58-11.436-38.734-19.789-59.901-24.829l-11.525-2.744v-52.862h-72.768v52.861l-11.525 2.744c-21.167 5.04-41.321 13.394-59.901 24.829l-10.091 6.21-37.391-37.392-51.454 51.454 37.391 37.392-6.21 10.091c-11.436 18.581-19.79 38.735-24.832 59.903l-2.744 11.525h-52.86v72.766h52.86l2.744 11.525c5.041 21.168 13.396 41.322 24.83 59.902l6.21 10.091-37.391 37.391 51.454 51.454 37.391-37.391 10.091 6.21c18.58 11.436 38.734 19.789 59.901 24.829l11.525 2.744v52.862h72.768v-52.861l11.525-2.744c21.167-5.04 41.321-13.394 59.901-24.829l10.091-6.21 37.391 37.392 51.455-51.455-37.392-37.391 6.21-10.091c11.436-18.581 19.789-38.734 24.829-59.902l2.744-11.525h52.863zm-256 195.402c-89.184 0-161.74-72.556-161.74-161.739 0-89.185 72.557-161.741 161.74-161.741s161.74 72.557 161.74 161.741c0 89.183-72.556 161.739-161.74 161.739z"
              />
            </g>
          </svg>
        </div>
        <RouterLink v-show="session.id" :to="`/working_times/${session.id}`">
          <button class="card-menu-button">Go to</button>
        </RouterLink>
      </div>

      <div class="card-menu">
        <h2 class="card-menu-title">Dashboard</h2>
        <p class="card-menu-description">
          Visualize your working times with charts and graphs
        </p>
        <div class="card-menu-icon">
          <svg viewBox="0 0 32 32">
            <g id="Layer_7" data-name="Layer 7">
              <path
                d="m31.9336 19.4463a16.0029 16.0029 0 0 0 -15.9385-15.3672c-.1269 0-.2549.0015-.3818.0049a16.0378 16.0378 0 0 0 -15.5576 15.9394 15.7648 15.7648 0 0 0 1.8076 7.36 1 1 0 0 0 .8867.5376h26.5a.9988.9988 0 0 0 .8867-.5376 15.9623 15.9623 0 0 0 1.7969-7.9371zm-8.5127-6.4863-4.9258 8.62a3.697 3.697 0 0 1 -5.916.8574 3.6953 3.6953 0 0 1 .8564-5.916l8.6211-4.9258a1 1 0 0 1 1.3643 1.3644zm-8.9932 5.2978 5.4375-3.1078-3.1064 5.437a1.6993 1.6993 0 0 1 -2.7656.4355 1.698 1.698 0 0 1 .4345-2.7652z"
              />
            </g>
          </svg>
        </div>
        <RouterLink v-show="session.id" :to="`/chart_manager/${session.id}`">
          <button class="card-menu-button">Go to</button>
        </RouterLink>
      </div>

      <div class="card-menu">
        <h2 class="card-menu-title">Profile</h2>
        <p class="card-menu-description">Update your user informations</p>
        <div class="card-menu-icon">
          <svg viewBox="0 0 512 512">
            <g>
              <g>
                <path
                  d="M256,0C114.844,0,0,114.844,0,256s114.844,256,256,256s256-114.844,256-256S397.156,0,256,0z M256,74.667
                  c67.635,0,122.667,55.031,122.667,122.667S323.635,320,256,320s-122.667-55.031-122.667-122.667S188.365,74.667,256,74.667z
                  M256,469.333c-69.707,0-131.52-33.755-170.473-85.615c42.676-20.534,103.621-42.385,170.473-42.385
                  c66.857,0,127.807,21.854,170.474,42.383C387.521,435.577,325.708,469.333,256,469.333z"
                />
              </g>
            </g>
          </svg>
        </div>
        <RouterLink v-show="session.id" :to="`/users/${session.id}`">
          <button class="card-menu-button">Go to</button>
        </RouterLink>
      </div>

      <div class="card-menu" v-if="session.isAuthoriseManager === true">
        <h2 class="card-menu-title">Manager view</h2>
        <p class="card-menu-description">Manager your users teams</p>
        <div class="card-menu-icon">
          <svg viewBox="0 0 512 512">
            <path
              d="m256 0c141.385 0 256 114.615 256 256s-114.615 256-256 256-256-114.615-256-256 114.615-256 256-256zm-155.831 315.337-.169 33.492h88.559c4.864-8.256 13.222-14.237 24.944-17.8.052-.013.1-.031.156-.043 2.068-.552 4-1.086 5.812-1.6l-.07-14.053c-3.239-7.134-9.812-12.131-20.062-15.265-6.5-1.748-11.848-3.291-15.921-4.5l-19.129 33.132a5.2 5.2 0 0 1 -9.008 0l-19.126-33.13c-4.08 1.208-9.423 2.757-15.915 4.5-10.26 3.134-16.832 8.125-20.071 15.265zm123.918-160.137a32.961 32.961 0 1 0 32.962-32.958 32.995 32.995 0 0 0 -32.962 32.958zm32.72 106.022a34.638 34.638 0 0 1 27.732 13.888h40.274a34.609 34.609 0 0 1 8.226-48.453c-4.761-8.116-13.1-13.919-25.414-17.669-9.023-2.433-16.176-4.506-21.752-6.178l-25.367 43.936a5.206 5.206 0 0 1 -9.011 0l-25.359-43.936c-5.585 1.672-12.738 3.745-21.761 6.178-11.922 3.631-20.107 9.179-24.938 16.9a34.613 34.613 0 0 1 9.361 49.226h40.273a34.646 34.646 0 0 1 27.736-13.888zm0 58.958a24.279 24.279 0 1 0 -24.276-24.28 24.3 24.3 0 0 0 24.276 24.281zm-120.493-65.212a24.276 24.276 0 1 0 24.276-24.276 24.3 24.3 0 0 0 -24.276 24.276zm240.982 0a24.274 24.274 0 1 0 -24.275 24.276 24.3 24.3 0 0 0 24.279-24.276zm-53.854 93.861h88.558l-.169-33.492c-3.238-7.134-9.811-12.131-20.061-15.265-6.5-1.748-11.848-3.3-15.921-4.5l-19.127 33.128a5.2 5.2 0 0 1 -9.011 0l-19.126-33.13c-4.168 1.241-9.406 2.747-15.921 4.5-10.253 3.134-16.826 8.125-20.062 15.265l-.073 14.053c1.816.509 3.744 1.043 5.812 1.6.052.012.1.03.156.043 11.723 3.564 20.083 9.545 24.945 17.8zm-127.225 40.93h119.566l-.168-33.492c-3.239-7.131-9.809-12.131-20.062-15.259-6.5-1.754-11.845-3.3-15.921-4.512l-19.126 33.131a5.207 5.207 0 0 1 -9.011 0l-19.127-33.127c-4.076 1.215-9.419 2.758-15.921 4.512-10.253 3.128-16.826 8.128-20.061 15.259z"
              fill-rule="evenodd"
            />
          </svg>
        </div>
        <RouterLink to="/managerView">
          <button class="card-menu-button">Go to</button>
        </RouterLink>
      </div>

      <div
        class="card-menu card-menu__last"
        v-if="session.isAuthoriseAdmin === true"
      >
        <h2 class="card-menu-title">Admin view</h2>
        <p class="card-menu-description">Administrate your users permissions</p>
        <div class="card-menu-icon">
          <svg viewBox="0 0 512 512">
            <path
              d="M256,151c-41.353,0-75,33.647-75,75c0,41.353,33.647,75,75,75c41.353,0,75-33.647,75-75C331,184.647,297.353,151,256,151z
              "
            />
            <path
              d="M501.746,211.776l-27.045-8.687c-5.479-22.734-14.414-44.297-26.66-64.292l12.29-24.58
              c2.886-5.771,1.758-12.744-2.813-17.314l-42.422-42.422c-4.585-4.585-11.528-5.684-17.314-2.813l-24.595,12.305
              c-18.252-11.147-38.042-19.585-59.019-25.166l-14.75-30.516C296.869,3.208,291.684,0,286,0h-60
              c-5.684,0-10.869,3.208-13.418,8.291l-14.751,30.517c-20.977,5.581-40.767,14.019-59.019,25.166l-24.595-12.305
              c-5.801-2.915-12.729-1.787-17.314,2.813L54.481,96.903c-4.57,4.57-5.698,11.543-2.813,17.314l12.305,24.595
              c-11.147,18.252-19.585,38.042-25.166,59.019L8.291,212.582C3.208,215.131,0,220.316,0,226v60c0,5.684,3.208,10.869,8.291,13.418
              l30.517,14.751c5.068,18.94,12.612,37.119,22.5,54.214l-10.459,31.362c-1.787,5.391-0.381,11.338,3.633,15.352l42.422,42.422
              c4.028,4.014,9.946,5.42,15.352,3.633l31.362-10.459c18.853,10.942,38.789,18.984,59.473,23.994l8.687,27.06
              C213.813,507.869,219.54,512,226,512h60c6.46,0,12.188-4.131,14.224-10.254l8.687-27.06c20.684-5.01,40.62-13.052,59.473-23.994
              l31.362,10.459c5.405,1.787,11.353,0.381,15.352-3.633l42.422-42.422c4.014-4.014,5.42-9.961,3.633-15.352l-10.459-31.362
              c10.942-18.853,18.984-38.789,23.994-59.473l27.06-8.687C507.869,298.188,512,292.46,512,286v-60
              C512,219.54,507.869,213.813,501.746,211.776z M256,421c-90.981,0-165-74.019-165-165S165.019,91,256,91s165,74.019,165,165
              S346.981,421,256,421z"
            />
            <path
              d="M328.951,301.247C310.036,319.587,284.359,331,256,331s-54.04-11.413-72.953-29.753
              c-12.393,12.252-21.903,27.437-27.092,44.562C180.687,373.334,216.167,391,256,391c39.825,0,75.302-17.659,100.032-45.176
              C350.848,328.691,341.341,313.5,328.951,301.247z"
            />
          </svg>
        </div>
        <RouterLink to="/adminView">
          <button class="card-menu-button">Go to</button>
        </RouterLink>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      session: {
        active: false,
        id: null,
        username: "",
        email: "",
        isAuthoriseAdmin: false,
        isAuthoriseManager: false,
        token: "",
      },
      clock: {
        id: -1,
        status: false,
        time: "",
        user: -1,
      },
      hours: 0,
      minutes: 0,
      seconds: 0,
      stopWatch: {
        hours: 0,
        minutes: 0,
        seconds: 0,
      },
      intervalId: null,
    };
  },
  async created() {
    if (!localStorage.session) {
      localStorage.session = JSON.stringify({
        ...this.session,
      });
    } else if (this.session.id !== JSON.parse(localStorage.session).id) {
      if (JSON.parse(localStorage.session)) {
        this.session = JSON.parse(localStorage.session);
      }
    }

    await this.getClock();

    setInterval(() => {
      this.setTime();
    }, 1000);

    this.intervalId = setInterval(() => {
      this.setTimer();
    }, 1000);
  },
  methods: {
    startClock: async function (startOrEnd) {
      var clockid = this.clock.id;
      if (clockid > 0) {
        await fetch(process.env.VUE_APP_API_URL + "/clocks/" + clockid, {
          method: "PUT",
          mode: "cors",
          headers: {
            "Content-type": "application/json; charset=UTF-8",
            Authorization: this.session.token,
          },
        })
          .then((response) => response.json())
          .then((result) => {
            if (result) {
              if (result.success) {
                this.clock = result.content;
                if (result.content.status) {
                  this.$toast.success("Clock started", {
                    position: "top-right",
                  });
                } else {
                  this.$toast.success("Clock stopped", {
                    position: "top-right",
                  });
                }
              } else if (result && result.error && result.error !== "") {
                this.$toast.error(result.error, {
                  position: "top-right",
                });
              }
            } else {
              this.$toast.error("Something went wrong while starting clock", {
                position: "top-right",
              });
            }
          });

        if (startOrEnd === "end") {
          clearInterval(this.intervalId);
          this.intervalId = null;
          this.stopWatch = {
            hours: 0,
            minutes: 0,
            seconds: 0,
          };
        } else {
          this.intervalId = setInterval(() => {
            this.setTimer();
          }, 1000);
        }
        await this.getClock();
      }
    },
    getClock: async function () {
      var userID = JSON.parse(localStorage.session).id;
      await fetch(process.env.VUE_APP_API_URL + "/clocks/" + userID, {
        mode: "cors",
        headers: {
          "Content-type": "application/json; charset=UTF-8",
          Authorization: this.session.token,
        },
      })
        .then((response) => response.json())
        .then((response) => {
          if (response) {
            if (response.success) {
              this.clock = response.content;
            } else if (response && response.error && response.error !== "") {
              this.$toast.error(response.error, {
                position: "top-right",
              });
            }
          } else {
            this.$toast.error("Something went wrong while retrieving clock", {
              position: "top-right",
            });
          }
        });
    },
    setTime() {
      const date = new Date();
      let hours = date.getHours();
      let minutes = date.getMinutes();
      let seconds = date.getSeconds();
      hours = hours <= 9 ? `${hours}`.padStart(2, 0) : hours;
      minutes = minutes <= 9 ? `${minutes}`.padStart(2, 0) : minutes;
      seconds = seconds <= 9 ? `${seconds}`.padStart(2, 0) : seconds;
      this.hours = hours;
      this.minutes = minutes;
      this.seconds = seconds;
    },
    setTimer() {
      if (this.clock && this.clock.status) {
        let milliseconds = Math.abs(
          Math.floor(new Date(this.clock.time).getTime() - new Date().getTime())
        );
        let seconds = Math.floor(milliseconds / 1000);
        let minutes = Math.floor(seconds / 60);
        let hours = Math.floor(minutes / 60);

        seconds = seconds % 60;
        minutes = minutes % 60;

        this.stopWatch.hours = hours;
        this.stopWatch.seconds = seconds;
        this.stopWatch.minutes = minutes;
      }
    },
  },
};
</script>

<style scoped lang="scss">
.homepage {
  width: 100%;
  height: 100%;
  overflow: auto;

  .menu-title-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 10%;
    margin-top: 2.5%;
    margin-bottom: 2.5%;

    .greeting-card {
      width: 25%;
      display: flex;
      justify-content: center;
      background: rgb(170, 111, 207);
      background: linear-gradient(
        90deg,
        rgba(170, 111, 207, 1) 0%,
        rgba(28, 28, 32, 0.2861519607843137) 50%
      );
      padding: 15px;
      border-radius: 15px;

      .menu-title {
        color: var(--color-2);
        margin: 0;
        font-size: 24px;
        font-weight: 500;
      }
    }

    @media screen and (min-width: 150px) and (max-width: 1320px) {
      margin-top: 25px;
    }
  }

  .card-menu-container {
    width: 100%;
    height: 40%;
    display: grid;
    grid-template-columns: auto auto auto auto;
    column-gap: 80px;
    row-gap: 80px;
    justify-content: center;

    .card-menu {
      width: 250px;
      height: 280px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      background-color: var(--bg-4);
      box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2),
        0 6px 20px 0 rgba(0, 0, 0, 0.19);
      text-align: center;
      border-radius: 15px;

      .card-menu-title {
        font-size: 18px;
        font-weight: 400;
        margin-top: 0px;
        margin-bottom: 15px;
        color: var(--color-2);
      }

      .card-menu-description {
        margin-bottom: 12px;
        color: var(--color-2);
        padding: 5px;
        font-size: 14px;
      }

      .card-menu-icon {
        margin-top: 5px;
        margin-bottom: 20px;

        svg {
          width: 36px;
          fill: var(--color-2);
        }
      }

      .card-menu-button {
        border: none;
        border-radius: 15px;
        padding: 5px;
        background-color: var(--color-1);
        color: var(--color-2);
        margin-top: 20px;
        width: 80px;
        height: 35px;
        font-size: 14px;
        font-weight: 400;
        text-align: center;

        &:hover {
          filter: brightness(1.25);
          cursor: pointer;
        }
      }
    }
  }
}

@media screen and (min-width: 150px) and (max-width: 1320px) {
  .homepage {
    .menu-title-container {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100%;
      height: 20%;
      margin-top: 5%;
      margin-bottom: 5%;

      .greeting-card {
        width: 95%;
        min-height: 75px;
        display: flex;
        justify-content: center;
        align-items: center;
        background: rgb(170, 111, 207);
        background: linear-gradient(
          90deg,
          rgba(170, 111, 207, 1) 0%,
          rgba(28, 28, 32, 0.2861519607843137) 50%
        );
        padding: 5px;
        border-radius: 10px;
        .menu-title {
          color: var(--color-2);
          margin: 0;
          font-size: 22px;
          font-weight: 500;
          text-align: center;
        }
      }
    }

    .card-menu-container {
      width: 95%;
      height: fit-content;
      margin: auto;
      display: grid;
      grid-template-columns: max-content;
      row-gap: 70px;
      justify-content: center;

      .card-menu {
        width: 75vw;
        height: 60vh;
        display: flex;
        flex-direction: column;
        justify-content: space-evenly;
        align-items: center;
        background-color: var(--bg-4);
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2),
          0 6px 20px 0 rgba(0, 0, 0, 0.19);
        text-align: center;
        border-radius: 15px;
        margin-left: auto;
        margin-right: auto;

        &__last {
          margin-bottom: 70px;
        }

        @media screen and (min-width: 400px) and (max-width: 650px) {
          width: 85%;
        }

        @media screen and (min-width: 150px) and (max-width: 400px) {
          width: 82.5%;
        }

        .card-menu-title {
          font-size: 24px;
          font-weight: 500;
          margin-top: 15px;
          margin-bottom: 20px;
          color: var(--color-2);
        }

        .card-menu-description {
          margin-bottom: 0;
          color: var(--color-2);
          padding: 5px;
          font-size: 18px;
          max-width: 80%;
        }

        .card-menu-icon {
          margin-top: 5px;
          margin-bottom: 20px;

          svg {
            width: 42px;
            fill: var(--color-2);
          }
        }

        .card-menu-button {
          border: none;
          border-radius: 20px;
          padding: 5px;
          background-color: var(--color-1);
          color: var(--color-2);
          margin-top: 10px;
          width: 140px;
          height: 55px;
          font-size: 20px;
          font-weight: 500;
          text-align: center;

          &:hover {
            filter: brightness(1.25);
            cursor: pointer;
          }
        }
      }
    }
  }
}
</style>

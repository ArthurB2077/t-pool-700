<script setup>
import router from "../router";
</script>

<template>
  <div class="login-logo-container">
    <img class="login-logo" src="../assets/tm_logo_lighter.png" />
  </div>
  <div v-if="!session || !session.active" class="login-form-container">
    <div class="login-form" role="form">
      <h5 class="login-form-title">Authentication</h5>
      <div class="login-form-fields">
        <div class="login-form-field">
          <label for="Username">Username</label>
          <input id="Username" type="text" v-model="user.username" />
        </div>
        <div class="login-form-field">
          <label for="Email">Email</label>
          <input id="Email" type="text" v-model="user.email" />
        </div>
        <div class="login-form-field">
          <label for="password">Password</label>
          <input id="password" type="password" v-model="user.password" />
        </div>
      </div>
      <div class="login-form-buttons">
        <button class="login-form-button-connect" v-on:click="logUser()">
          Connect
        </button>
        <span class="login-form-button-separator"></span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      user: {
        username: "",
        id: "",
        email: "",
        password: "",
        isAuthoriseAdmin: false,
        isAuthoriseManager: false,
        token: "",
      },
      session: {
        active: false,
        id: null,
        username: "",
        email: "",
        isAuthoriseAdmin: false,
        isAuthoriseManager: false,
        token: "",
      },
    };
  },
  created() {
    if (!localStorage.session) {
      localStorage.session = JSON.stringify({
        ...this.session,
      });
    } else {
      if (JSON.parse(localStorage.session)) {
        this.session = JSON.parse(localStorage.session);
      } else {
        localStorage.session = JSON.stringify({
          ...this.session,
        });
      }
    }
  },
  methods: {
    logUser: async function () {
      fetch(process.env.VUE_APP_API_URL + "/auth/login", {
        mode: "cors",
        method: "POST",
        body: JSON.stringify({
          username: this.user.username,
          email: this.user.email,
          password: this.user.password,
        }),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
        },
      })
        .then((response) => {
          if (response.ok) {
            return response.json();
          } else {
            this.$toast.error("Invalid credentials", {
              position: "top-right",
            });
            throw new Error("Invalid credentials");
          }
        })
        .then((response) => {
          if (response.success) {
            this.$toast.success(response.message, {
              position: "top-right",
            });
            this.registerUser(
              true,
              response.user.id,
              response.user.username,
              response.user.email,
              response.user.isAuthoriseAdmin,
              response.user.isAuthoriseManager,
              response.token
            );
            router.push("/home");
          } else if (response.error && response.error !== "") {
            this.$toast.error(response.error, {
              position: "top-right",
            });
          } else {
            this.$toast.error(
              "Something went wrong. Please try again or contact your administrator",
              {
                position: "top-right",
              }
            );
          }
        });
    },
    registerUser: function (
      active,
      id,
      username,
      email,
      isAuthoriseAdmin,
      isAuthoriseManager,
      token
    ) {
      if (this.checkUserInfos(active, id, username, email)) {
        const newSession = {
          active: active,
          id: id,
          username: username,
          email: email,
          isAuthoriseAdmin: isAuthoriseAdmin,
          isAuthoriseManager: isAuthoriseManager,
          token: token,
        };
        this.session = newSession;
        localStorage.session = JSON.stringify(newSession);
      } else {
        const newSession = {
          active: false,
          id: null,
          username: "",
          email: "",
          isAuthoriseAdmin: false,
          isAuthoriseManager: false,
          token: "",
        };
        this.session = newSession;
        localStorage.session = JSON.stringify(newSession);
      }
    },
    checkUserInfos: function (active, id, username, email) {
      return (
        typeof active === "boolean" &&
        typeof id === "number" &&
        typeof username === "string" &&
        username.length > 0 &&
        typeof email === "string" &&
        email.length > 0
      );
    },
  },
};
</script>

<style lang="scss" scoped>
.login-logo-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 22.5%;
  margin-bottom: 15px;

  @media screen and (min-width: 150px) and (max-width: 650px) {
    height: 17.5%;
  }

  .login-logo {
    width: 200px;

    @media screen and (min-width: 150px) and (max-width: 650px) {
      width: 130px;
    }
  }
}

.login-form-container {
  width: 100%;
  height: 70%;
  display: flex;
  justify-content: center;
  align-items: center;

  @media screen and (min-width: 150px) and (max-width: 650px) {
    width: 90%;
    height: 76%;
    margin: auto;
  }

  .login-form {
    width: 32.5em;
    height: 100%;
    margin: auto;
    background-color: var(--bg-4);
    border-radius: 25px;
    padding: 50px 25px;

    @media screen and (min-width: 150px) and (max-width: 650px) {
      padding: 30px 15px;
    }

    .login-form-title {
      width: 90%;
      margin: auto;
      font-size: 28px;
      color: var(--color-2);
      margin-top: 0;
      margin-bottom: 30px;
      padding-left: 10px;

      @media screen and (min-width: 150px) and (max-width: 650px) {
        font-size: 24px;
        margin-left: 0;
        margin-bottom: 20px;
      }
    }

    .login-form-fields {
      width: 90%;
      display: flex;
      flex-direction: column;
      justify-content: center;
      margin: auto;

      @media screen and (min-width: 150px) and (max-width: 650px) {
        width: 95%;
      }

      .login-form-field {
        label {
          margin: 5px 10px;
          font-size: 16px;

          @media screen and (min-width: 150px) and (max-width: 650px) {
            margin: 5px 0;
          }
        }

        input {
          color: #ffffff;
          background-color: var(--bg-1);
          font-size: 20px;
          border-bottom: none;
          border-radius: 10px;
          margin: 0 10px;
          margin-top: 7.5px;
          margin-bottom: 30px;
          margin-left: 10px;
          margin-right: 15px;
          padding-left: 15px;
          padding-right: 10px;
          height: 45px;
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

          @media screen and (min-width: 150px) and (max-width: 650px) {
            margin: 15px 0;
            height: 40px;
          }
        }
      }
    }

    .login-form-buttons {
      display: flex;
      justify-content: center;
      align-items: center;
      flex-direction: column;
      margin-top: 25px;

      .login-form-button-separator {
        width: 80%;
        border-top: 1px solid var(--color-1);
        margin-top: 5%;

        @media screen and (min-width: 150px) and (max-width: 650px) {
          display: none;
        }
      }

      .login-form-button-connect {
        border: none;
        padding: 5px;
        background-color: var(--color-4);
        border-radius: 25px;
        color: var(--color-2);
        margin-top: 0;
        margin-bottom: 20px;
        width: 140px;
        height: 55px;
        font-size: 18px;
        font-weight: 500;
        text-align: center;

        &:hover {
          filter: brightness(1.25);
          cursor: pointer;
        }

        @media screen and (min-width: 150px) and (max-width: 650px) {
          width: 130px;
          height: 50px;
        }
      }
    }
  }
}
</style>

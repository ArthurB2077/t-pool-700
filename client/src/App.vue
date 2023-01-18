<script setup>
import TimeManagerView from "./views/TimeManagerView.vue";
</script>

<template>
  <TimeManagerView />
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
        isAuthoriseAdmin: "",
        isAuthoriseManager: "",
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
};
</script>

<style lang="scss">
@media screen and (min-width: 150px) and (max-width: 550px) {
  #app {
    padding: 0 !important;
    margin: 0 !important;
  }
}
</style>

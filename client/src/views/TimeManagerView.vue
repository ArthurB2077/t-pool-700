<script setup>
import { RouterView } from "vue-router";
import Navbar from "../components/Navbar.vue";
</script>

<template>
  <header class="header">
    <Navbar />
  </header>
  <main class="main-content">
    <RouterView />
  </main>
</template>

<style scoped lang="scss">
.header {
  height: 95%;
  width: 7em;
  position: absolute;
  z-index: 2;
}
.main-content {
  background-color: var(--bg-3);
  height: 100%;
  width: calc(100% - 7em);
  margin-left: 7em;
  padding: 2vh 1vw;
  border-radius: 15px;
}
@media screen and (min-width: 150px) and (max-width: 550px) {
  .header {
    height: 10%;
    width: 100%;
    bottom: 0;
  }
  .main-content {
    margin-top: 0;
    margin-bottom: 0;
    margin-left: auto;
    margin-right: auto;
    height: 90%;
    padding: 0;
    width: 100%;
    border-radius: 0;
  }
}
</style>

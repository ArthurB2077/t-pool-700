<template>
  <div class="dashboard-all-container">
    <div class="dashboard-bar-container">
      <Bar />
    </div>
    <div class="dashboard-line-container">
      <Line />
    </div>
    <div class="dashboard-doughnut-container">
      <Doughnut />
    </div>
  </div>
</template>

<script>
import Bar from "./Bar.vue";
import Line from "./Line.vue";
import Doughnut from "./Doughnut.vue";
export default {
  components: {
    Bar,
    Line,
    Doughnut,
  },
  data: function () {
    return {};
  },
};
</script>

<style scoped lang="scss">
.dashboard-all-container {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: space-evenly;
  align-items: stretch;
  .dashboard-bar-container {
    width: 33%;
    height: fit-content;
    display: flex;
    justify-content: center;

    @media screen and (min-width: 150px) and (max-width: 1300px) {
      width: 98vw;
      display: block;
    }
  }

  .dashboard-line-container {
    width: 33%;
    height: fit-content;
    display: flex;
    justify-content: center;

    @media screen and (min-width: 150px) and (max-width: 1300px) {
      width: 98vw;
      margin-left: auto;
      margin-right: auto;
    }
  }

  .dashboard-doughnut-container {
    width: 33%;
    height: fit-content;
    display: flex;
    justify-content: center;

    @media screen and (min-width: 150px) and (max-width: 1300px) {
      width: 98vw;
      margin-left: auto;
      margin-right: auto;
      margin-bottom: 0;
    }
  }

  @media screen and (min-width: 150px) and (max-width: 1300px) {
    display: grid;
    grid-template-columns: auto;
    grid-row-gap: 0;
    align-items: inherit;
    margin-top: inherit;
    height: fit-content;
    max-width: 100%;
  }
}
</style>

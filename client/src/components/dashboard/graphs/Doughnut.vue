<template>
  <div class="card-chart card">
    <div class="card-chart card-content">
      <div class="chart-header">
        <h3 class="chart-card-title">Day Working time</h3>
        <span class="chart-card-info">{{ dayShow }} </span>
        <div class="donught-date-container">
          <button class="chart-date-button" v-on:click="changeDay">
            Display date
          </button>
          <input class="date-input" type="date" v-model="day" />
        </div>
      </div>
      <div class="bar-chart-container">
        <Doughnut
          v-if="loaded"
          :chartData="chartData"
          :chartOptions="chartOptions"
          :chartId="chartId"
          :width="width"
          :height="height"
          :cssClasses="cssClasses"
          :styles="styles"
          :plugins="plugins"
        />
      </div>
    </div>
  </div>
</template>

<script>
import { Doughnut } from "vue-chartjs";
import moment from "moment-timezone";
import WorkingTime from "../../../api/WorkingTime";
import tools from "../../../utils/tools";
import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  ArcElement,
  CategoryScale,
} from "chart.js";

ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale);
export default {
  name: "DoughnutChart",
  components: {
    Doughnut,
  },
  props: {
    chartId: {
      type: String,
      default: "doughnut-chart",
    },
    width: {
      type: Number,
      default: 400,
    },
    height: {
      type: Number,
      default: 400,
    },
    cssClasses: {
      default: "",
      type: String,
    },
    plugins: {
      type: Array,
      default: () => [],
    },
  },
  data: () => ({
    loaded: false,
    chartData: null,
    startV: null,
    endV: null,
    dayShow: null,
    day: null,
    break: null,
    work: null,
    off: null,
  }),
  methods: {
    async changeDay() {
      this.dayShow = this.day;
      if (this.day) {
        this.startV = tools.convertLocalToGMT(
          moment(this.day + "T00:00:00")
            .tz(tools.timezone)
            .format(),
          false,
          true
        );
        this.endV = tools.convertLocalToGMT(
          moment(this.day + "T23:59:59")
            .tz(tools.timezone)
            .format(),
          false,
          false
        );
        await this.show(this.startV, this.endV);
      } else {
        window.alert("Please enter a valid date");
      }
    },
    async show(start, end) {
      const userID = this.$route.params.userID;
      const teamID = this.$route.params.teamID;
      if (userID !== undefined) {
        const res = await WorkingTime.getAllWorkingTimesUser(
          userID,
          start,
          end
        );
        if (res.success) {
          const getDayStatsResult = tools.getDayStats(res.content);
          this.break = getDayStatsResult.break.toFixed(1);
          this.work = getDayStatsResult.work.toFixed(1);
          this.off = getDayStatsResult.off.toFixed(1);
          this.chartData = {
            labels: ["Working", "Break", "Off"],
            datasets: [
              {
                backgroundColor: ["#41B883", "#E46651", "#00D8FF"],
                data: [this.work, this.break, this.off],
              },
            ],
          };
          this.chartOptions = {
            responsive: true,
            maintainAspectRatio: false,
          };
        } else {
          this.break = 0;
          this.work = 0;
          this.off = 0;
          this.chartData = {
            labels: ["Working", "Break", "Off"],
            datasets: [
              {
                backgroundColor: ["#41B883", "#E46651", "#00D8FF"],
                data: [this.work, this.break, this.off],
              },
            ],
          };
          this.chartOptions = {
            responsive: true,
            maintainAspectRatio: false,
          };
        }
      } else if (teamID) {
        const res = await WorkingTime.retrieveWorkingTimeByTeam(
          teamID,
          start,
          end
        );

        if (res.success) {
          const getDayStatsResult = tools.getDayStats(res.content);
          this.break = getDayStatsResult.break.toFixed(1);
          this.work = getDayStatsResult.work.toFixed(1);
          this.off = getDayStatsResult.off.toFixed(1);
          this.chartData = {
            labels: ["Working", "Break", "Off"],
            datasets: [
              {
                backgroundColor: ["#41B883", "#E46651", "#00D8FF"],
                data: [this.work, this.break, this.off],
              },
            ],
          };
          this.chartOptions = {
            responsive: true,
            maintainAspectRatio: false,
          };
        } else {
          this.break = 0;
          this.work = 0;
          this.off = 0;
          this.chartData = {
            labels: ["Working", "Break", "Off"],
            datasets: [
              {
                backgroundColor: ["#41B883", "#E46651", "#00D8FF"],
                data: [this.work, this.break, this.off],
              },
            ],
          };
          this.chartOptions = {
            responsive: true,
            maintainAspectRatio: false,
          };
        }
      }
    },
  },
  async mounted() {
    this.loaded = false;
    try {
      const today = new Date();
      const todayLimits = tools.getDayLimits();
      this.dayShow = moment(today).tz(tools.timezone).format();
      this.dayShow = this.dayShow.split("T")[0];
      this.startV = todayLimits.utcStart;
      this.endV = todayLimits.utcEnd;
      await this.show(this.startV, this.endV);
      this.timer = setInterval(() => {
        this.show(this.startV, this.endV);
      }, 60000);
      this.loaded = true;
    } catch (err) {
      console.log(err);
    }
  },
  computed: {
    styles() {
      return {
        height: "400px",
      };
    },
  },
};
</script>

<style scoped lang="scss">
.card-chart {
  background-color: var(--bg-4);
  color: var(--color-2);
  border-radius: 10px !important;
  margin: 0;
  height: 600px;
  width: 95%;

  @media screen and (min-width: 150px) and (max-width: 1300px) {
    height: fit-content;
    width: calc(100% - 20px);
    margin-left: 10px;
    margin-right: 10px;
    margin-bottom: 6vh;
    padding: 10px 5px !important;
  }

  .chart-header {
    height: 30%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;

    .donught-date-container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;

      .chart-date-button {
        border: none;
        border-radius: 15px;
        padding: 5px;
        background-color: var(--color-1);
        color: var(--color-2);
        width: 125px;
        height: 35px;
        font-size: 18px;
        font-weight: 400;
        text-align: center;
        color: white;

        &:hover {
          filter: brightness(1.25);
          cursor: pointer;
        }

        svg {
          fill: var(--color-2);
          width: 10px;
        }
      }

      .date-input {
        color: var(--color-2);
        width: 120px;
        font-size: 16px;
        font-weight: 400;
        height: 30px;
        border-bottom: 1px solid var(--color-1);
        color: var(--color-2);
        font-size: 18px;
        &::-webkit-calendar-picker-indicator {
          filter: invert(100%);
          &:hover {
            cursor: pointer;
          }
        }
      }
    }

    .chart-card-title {
      font-size: 20px;
      font-weight: 400;
      margin: 0;
    }

    .chart-card-info {
      font-size: 18px;
      font-weight: 400;
      @media screen and (min-width: 150px) and (max-width: 1300px) {
        margin: 15px 0;
      }
    }
  }

  .bar-chart-container {
    background-color: white;
    border-radius: 10px;
    overflow-x: auto;
  }
}
</style>

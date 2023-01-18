<template>
  <div class="card-chart card">
    <div class="card-chart card-content">
      <div class="line-chart-header">
        <h3 class="chart-card-title">Year Working time</h3>
        <span class="chart-card-info"
          >Total: {{ totalYearWorkTime }} days (7h)</span
        >
      </div>
      <div class="bar-chart-container">
        <Line
          v-if="loaded"
          :chartOptions="chartOptions"
          :chartData="chartData"
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
import { Line } from "vue-chartjs";

import WorkingTime from "../../../api/WorkingTime";
import tools from "../../../utils/tools";

import {
  Chart as ChartJS,
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale,
} from "chart.js";

ChartJS.register(
  Title,
  Tooltip,
  Legend,
  LineElement,
  LinearScale,
  PointElement,
  CategoryScale
);

export default {
  name: "LineChart",
  components: { Line },
  props: {
    chartId: {
      type: String,
      default: "line-chart",
    },
    width: {
      type: Number,
      default: 470,
    },
    height: {
      type: Number,
      default: 200,
    },
    cssClasses: {
      default: "",
      type: String,
    },
    plugins: {
      type: Array,
      default: () => {},
    },
  },
  data: () => ({
    loaded: false,
    chartData: null,
    startShow: null,
    endShow: null,
    // weekWorkingTime: null,
    totalYearWorkTime: null,
    labelsDates: null,
    startV: null,
    endV: null,
    // colorWeek: "blue",
    // contract: 35
  }),
  methods: {
    async showYear(start, end) {
      const userID = this.$route.params.userID;
      const teamID = this.$route.params.teamID;
      if (userID !== undefined) {
        const res = await WorkingTime.getAllWorkingTimesUser(
          userID,
          start,
          end
        );
        const getWorkingTimeByMonth = tools.getWorkingTimeByMonth(res.content);
        this.graphData = getWorkingTimeByMonth.weekWorkTimeByMonth;
        this.totalYearWorkTime = getWorkingTimeByMonth.totalYearTime;
        this.year = new Date(start).getFullYear();
        this.labels = [
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        ];
      } else if (teamID) {
        const res = await WorkingTime.retrieveWorkingTimeByTeam(
          teamID,
          start,
          end
        );
        const getWorkingTimeByMonth = tools.getWorkingTimeByMonth(res.content);
        this.graphData = getWorkingTimeByMonth.weekWorkTimeByMonth;
        this.totalYearWorkTime = getWorkingTimeByMonth.totalYearTime;
        this.year = new Date(start).getFullYear();
        this.labels = [
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        ];
      }
    },
    async showMonth(month) {},
  },
  async mounted() {
    this.loaded = false;

    try {
      const thisYearLimits = tools.getThisYearLimits();
      this.startV = thisYearLimits.startThisYear;
      this.endV = thisYearLimits.utcEndThisYear;

      await this.showYear(this.startV, this.endV);

      this.chartData = {
        labels: this.labels,
        datasets: [
          {
            label: "Data One",
            backgroundColor: "#f87979",
            data: this.graphData,
          },
        ],
      };
      this.chartOptions = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          },
        },
      };
      // await this.show(this.startV, this.endV)
      // this.timer = setInterval(() => {
      //   this.show(this.startV, this.endV)
      // }, 60000)
      this.loaded = true;
    } catch (e) {
      console.error(e);
    }
  },
  beforeUnmount() {
    clearInterval(this.timer);
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
  padding: 0px;
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

  .line-chart-header {
    height: 25%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;

    .chart-card-title {
      font-size: 20px;
      font-weight: 400;
      margin-top: 0;
    }

    .chart-card-info {
      font-size: 18px;
      font-weight: 400;
      margin-bottom: 25%;
      @media screen and (min-width: 150px) and (max-width: 1300px) {
        margin-bottom: 20px;
      }
    }
  }

  .bar-chart-container {
    background-color: white;
    border-radius: 10px;
  }
}
</style>

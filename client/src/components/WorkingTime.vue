<template>
  <div class="wt-view">
    <div class="wt-view-container">
      <div class="menu-title-container">
        <div class="greeting-card">
          <h1 class="menu-title">Working times</h1>
        </div>
      </div>

      <div class="wt-toggle-container">
        <Toggle v-model="listView" offLabel="Calendar" onLabel="List" />
      </div>

      <div v-if="listView" class="wt-list-accordion">
        <div class="wt-accordion-header">
          <h2 class="wt-list-name">Working times</h2>
          <div class="wt-list-search">
            <input
              class="wt-list-search-input"
              id="search"
              name="search"
              type="text"
              v-model="searchParams"
              placeholder="Search for date"
            />
          </div>
          <button @click="openCreateWt('create')" class="wt-list-charts-link">
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
            Add
          </button>
        </div>
        <div class="wt-accordion-content">
          <table class="wt-list-member-table">
            <thead class="wt-list-member-header">
              <tr class="wt-list-member-header-row">
                <th class="wt-list-member-header-cell">Start</th>
                <th class="wt-list-member-header-cell">End</th>
                <th
                  class="wt-list-member-header-cell wt-list-member-header-cell__action"
                >
                  Actions
                </th>
              </tr>
            </thead>
            <tbody class="wt-list-member-body">
              <tr
                v-for="w in displayedWorkingTimes"
                :key="w.id"
                class="wt-list-member-body-row"
              >
                <td class="wt-list-member-body-cell">
                  {{ readableDatetime(w.start) }}
                </td>
                <td class="wt-list-member-body-cell">
                  {{ readableDatetime(w.end) }}
                </td>
                <td
                  class="wt-list-member-body-cell wt-list-member-body-cell__action"
                >
                  <button
                    class="wt-list-member-body-link"
                    @click="
                      openSelectedWorkingTime(
                        {
                          customData: {
                            startTime: w.start,
                            endTime: w.end,
                            id: w.id,
                          },
                        },
                        'update'
                      )
                    "
                  >
                    <svg class="wt-list-member-body-icon" viewBox="0 0 512 511">
                      <path
                        d="m405.332031 256.484375c-11.796875 0-21.332031 9.558594-21.332031 21.332031v170.667969c0 11.753906-9.558594 21.332031-21.332031 21.332031h-298.667969c-11.777344 0-21.332031-9.578125-21.332031-21.332031v-298.667969c0-11.753906 9.554687-21.332031 21.332031-21.332031h170.667969c11.796875 0 21.332031-9.558594 21.332031-21.332031 0-11.777344-9.535156-21.335938-21.332031-21.335938h-170.667969c-35.285156 0-64 28.714844-64 64v298.667969c0 35.285156 28.714844 64 64 64h298.667969c35.285156 0 64-28.714844 64-64v-170.667969c0-11.796875-9.539063-21.332031-21.335938-21.332031zm0 0"
                      />
                      <path
                        d="m200.019531 237.050781c-1.492187 1.492188-2.496093 3.390625-2.921875 5.4375l-15.082031 75.4375c-.703125 3.496094.40625 7.101563 2.921875 9.640625 2.027344 2.027344 4.757812 3.113282 7.554688 3.113282.679687 0 1.386718-.0625 2.089843-.210938l75.414063-15.082031c2.089844-.429688 3.988281-1.429688 5.460937-2.925781l168.789063-168.789063-75.414063-75.410156zm0 0"
                      />
                      <path
                        d="m496.382812 16.101562c-20.796874-20.800781-54.632812-20.800781-75.414062 0l-29.523438 29.523438 75.414063 75.414062 29.523437-29.527343c10.070313-10.046875 15.617188-23.445313 15.617188-37.695313s-5.546875-27.648437-15.617188-37.714844zm0 0"
                      />
                    </svg>
                    <span class="wt-list-member-body-text">Edit</span>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
          <div
            class="wt-table-pagination-container"
            aria-label="Table pagination"
          >
            <ul class="wt-table-pagination">
              <li class="wt-table-page-item">
                <button
                  type="button"
                  :disabled="page == 1"
                  :class="
                    page != 1
                      ? 'wt-table-page-link'
                      : 'wt-table-page-link wt-table-page-link__disabled'
                  "
                  @click="page--"
                >
                  Prev
                </button>
              </li>
              <li class="wt-table-page-item">
                <button
                  type="button"
                  :class="
                    page === pageNumber
                      ? 'wt-table-page-link-number wt-table-page-link-number__current'
                      : 'wt-table-page-link-number'
                  "
                  v-for="pageNumber in pages.slice(
                    page - 1,
                    page + setPagainationWidth()
                  )"
                  @click="page = pageNumber"
                >
                  {{ pageNumber }}
                </button>
              </li>
              <li class="wt-table-page-item">
                <button
                  type="button"
                  @click="page++"
                  :disabled="page == pages.length"
                  :class="
                    page < pages.length
                      ? 'wt-table-page-link'
                      : 'wt-table-page-link wt-table-page-link__disabled'
                  "
                >
                  Next
                </button>
              </li>
            </ul>
          </div>
        </div>
      </div>

      <v-calendar
        class="custom-calendar max-w-full"
        :masks="masks"
        :attributes="attributes"
        disable-page-swipe
        is-expanded
        v-if="!listView"
      >
        <template v-slot:day-content="{ day, attributes }">
          <div
            class="cell-container-cell-2 flex flex-col h-full z-10 overflow-hidden"
          >
            <span
              class="cell-container-cell-1 day-label text-sm text-gray-900"
              >{{ day.day }}</span
            >
            <div
              class="cell-container-cell flex-grow overflow-y-auto overflow-x-auto"
              style="z-index: 0"
            >
              <div
                v-for="attr in attributes"
                :key="attr.key"
                class="cell-container text-xs leading-tight rounded-sm p-1 mt-0 mb-1 calendarBorder"
                :class="attr.customData.class"
                :id="attr.customData.id"
                style="z-index: 0"
              >
                <p
                  @click="openSelectedWorkingTime(attr, 'update')"
                  class="cell"
                >
                  <span class="dot"></span>
                  {{ attr.customData.start }} - {{ attr.customData.end }}
                </p>
              </div>
            </div>
          </div>
        </template>
      </v-calendar>
    </div>

    <div class="modal-update-wt" v-show="editVisible">
      <div class="modal-mask">
        <div class="modal-wrapper">
          <div class="modal-container">
            <div class="modal-header">
              <slot name="header"></slot>
            </div>
            <div class="modal-body">
              <label
                for="selectedStart"
                class="block text-sm font-medium text-gray-700"
                >Start</label
              >
              <input
                type="datetime-local"
                name="selectedStart"
                id="selectedStart"
                v-model="selectedStart"
                class="mt-1 block w-full rounded-md border border p-2"
              />
              <label
                for="selectedEnd"
                class="block text-sm font-medium text-gray-700"
                >End</label
              >
              <input
                type="datetime-local"
                name="selectedEnd"
                id="selectedEnd"
                v-model="selectedEnd"
                class="mt-1 block w-full rounded-md border border p-2"
              />
            </div>
            <div class="modal-footer">
              <div>
                <button
                  class="modal-footer-button modal-footer-button__green"
                  v-on:click="
                    mode === 'create'
                      ? createWorkingTime()
                      : updateWorkingTime()
                  "
                >
                  <span v-if="mode === 'create'">Create</span>
                  <span v-else>Update</span>
                  <span></span>
                </button>
                <button
                  v-if="mode === 'update'"
                  class="modal-footer-button modal-footer-button__red"
                  @click="deleteWorkingTime(wtId)"
                >
                  Delete
                </button>
              </div>
              <button class="modal-footer-button" @click="hideModal()">
                Cancel
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import "v-calendar/dist/style.css";
import Toggle from "@vueform/toggle";
import WorkingTime from "@/api/WorkingTime";

export default {
  components: {
    Toggle,
  },
  data() {
    return {
      wT: [],
      visible: false,
      masks: {
        weekdays: "WWW",
      },
      attributes: [],
      selectedStart: "2000-01-01T00:00:00",
      selectedEnd: "2000-01-01T01:00:00",
      editVisible: false,
      wtId: null,
      mode: null,
      listView: true,
      searchParams: "",
      // Pagination
      page: 1,
      perPage: 5,
      pages: [],
    };
  },
  async created() {
    await this.getWorkingTimesUser();
  },
  methods: {
    getWorkingTimesUser: async function () {
      const id = parseInt(this.$route.params.userID);

      const response = await fetch(
        process.env.VUE_APP_API_URL + "/workingtimes/" + id,
        {
          mode: "cors",
          headers: {
            "Content-type": "application/json; charset=UTF-8",
            Authorization: JSON.parse(localStorage.session).token,
          },
        }
      );

      const { content: workingTimes, success: success } = await response.json();

      if (success && workingTimes && workingTimes.length > 0) {
        this.wT = workingTimes;
        var myObjs = [];
        var cpt = 1;
        this.wT.forEach((element) => {
          var dateStart = element.start.slice(0, -1);
          var dateEnd = element.end.slice(0, -1);
          //date de départ
          var date = element.start;
          date = date.split("T");
          var dateYMD = date[0].split("-");
          var hours = date[1].slice(0, -1);
          //date de fin
          var endDate = element.end;
          endDate = endDate.split("T");
          var hoursend = endDate[1].slice(0, -1);
          var myobj = {
            key: cpt,
            isVisible: false,
            customData: {
              id: element.id,
              title: "workingTime",
              class: "bg-red-600 text-white",
              startTime: dateStart,
              endTime: dateEnd,
              start: hours,
              end: hoursend,
            },
            dates: new Date(dateYMD[0], parseInt(dateYMD[1]) - 1, dateYMD[2]),
          };
          myObjs.push(myobj);
          cpt++;
        });
        this.attributes = myObjs;
      }
    },
    openSelectedWorkingTime: function (attr, mode) {
      this.mode = mode;
      this.editVisible = true;
      this.selectedStart = attr.customData.startTime.replace("Z", "");
      this.selectedEnd = attr.customData.endTime.replace("Z", "");
      this.wtId = attr.customData.id;
    },
    openCreateWt: function (mode) {
      this.mode = mode;
      this.editVisible = true;
      this.selectedStart = null;
      this.selectedEnd = null;
      this.wtId = null;
    },
    createWorkingTime: async function () {
      this.selectedStart =
        this.selectedStart.split(":").length === 2
          ? this.selectedStart + ":00Z"
          : this.selectedStart + "Z";
      this.selectedEnd =
        this.selectedEnd.split(":").length === 2
          ? this.selectedEnd + ":00Z"
          : this.selectedEnd + "Z";
      fetch(
        process.env.VUE_APP_API_URL +
          "/workingtimes/" +
          this.$route.params.userID,
        {
          mode: "cors",
          method: "POST",
          body: JSON.stringify({
            start: this.selectedStart,
            end: this.selectedEnd,
          }),
          headers: {
            "Content-type": "application/json; charset=UTF-8",
            Authorization: JSON.parse(localStorage.session).token,
          },
        }
      )
        .then((response) => response.json())
        .then((json) => {
          this.editVisible = false;
        });
      this.selectedStart = this.selectedStart.replace("Z", "");
      this.selectedEnd = this.selectedEnd.replace("Z", "");
    },
    updateWorkingTime: async function () {
      var newSt = this.selectedStart;
      newSt = newSt.split(":").length === 2 ? newSt + ":00Z" : newSt + "Z";
      var newEt = this.selectedEnd;
      newEt = newEt.split(":").length === 2 ? newEt + ":00Z" : newEt + "Z";

      fetch(process.env.VUE_APP_API_URL + "/workingtimes/" + this.wtId, {
        mode: "cors",
        method: "PUT",
        body: JSON.stringify({
          start: newSt,
          end: newEt,
        }),
        headers: {
          "Content-type": "application/json; charset=UTF-8",
          Authorization: JSON.parse(localStorage.session).token,
        },
      })
        .then((response) => response.json())
        .then((json) => {
          this.editVisible = false;
        });
    },
    deleteWorkingTime: async function (id) {
      const response = await WorkingTime.deleteWorkingTimesUser(id);
      if (response) {
        if (response.success) {
          this.$toast.success("Working time deleted", {
            position: "top-right",
          });
          this.hideModal();
        } else {
          this.$toast.error(response.error, {
            position: "top-right",
          });
        }
      } else {
        this.$toast.error("Something went wrong while deleted working time", {
          position: "top-right",
        });
      }
    },
    hideModal: function () {
      this.editVisible = false;
    },
    switchView: function () {
      this.listView = !this.listView;
    },
    readableDatetime: function (datetime) {
      return `${datetime.split("T")[0]} ${datetime
        .split("T")[1]
        .replace("Z", "")}`;
    },
    filterBySearchWt: function () {
      return this.searchParams && this.searchParams !== ""
        ? this.wT
            .filter(
              (w) =>
                w.start.includes(this.searchParams) ||
                w.end.includes(this.searchParams)
            )
            .sort(
              (prev, next) =>
                new Date(next.start).getTime() - new Date(prev.start).getTime()
            )
        : this.wT.sort(
            (prev, next) => new Date(next.start) - new Date(prev.start)
          );
    },
    setPages() {
      let numberOfPages = Math.ceil(
        this.filterBySearchWt().length / this.perPage
      );
      let newPage = [];
      for (let index = 1; index <= numberOfPages; index++) {
        newPage.push(index);
      }
      if (
        newPage.length !== this.pages.length ||
        !newPage.every((page, index) => page === this.pages[index])
      ) {
        this.pages = newPage;
      }
    },
    paginate(data) {
      let page = this.page;
      let perPage = this.perPage;
      let from = page * perPage - perPage;
      let to = page * perPage;
      return data.slice(from, to);
    },
    setPagainationWidth() {
      if (window.innerWidth > 600) {
        return 5;
      } else {
        return 2;
      }
    },
  },
  computed: {
    displayedWorkingTimes() {
      return this.paginate(this.filterBySearchWt());
    },
  },
  watch: {
    async editVisible() {
      await this.getWorkingTimesUser();
    },
    wT() {
      this.setPages();
    },
    searchParams() {
      this.page = 1;
      this.setPages();
    },
  },
};
</script>

<style lang="scss" scoped>
.wt-view {
  width: 100%;
  height: 100%;

  .wt-view-container {
    overflow: hidden;
    max-height: 100%;

    .menu-title-container {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100%;
      height: 10%;
      margin-top: 2.5%;
      margin-bottom: 2.5%;

      @media screen and (min-width: 150px) and (max-width: 550px) {
        margin-top: 10%;
        margin-bottom: 10%;
      }

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

        @media screen and (min-width: 150px) and (max-width: 550px) {
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

    .wt-toggle-container {
      margin: 10px;

      @media screen and (min-width: 150px) and (max-width: 850px) {
        display: none;
      }
    }

    .wt-list-accordion {
      margin: 10px;

      .wt-accordion-header {
        height: 5em;
        background-color: var(--bg-4);
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        display: flex;
        align-items: center;
        padding: 20px;
        justify-content: space-between;

        .wt-list-name {
          color: var(--color-2);
          font-size: 22px;
          font-weight: 500;
          margin: 0;
          width: fit-content;

          @media screen and (min-width: 150px) and (max-width: 550px) {
            display: none;
          }
        }

        .wt-list-search {
          width: 25%;
          display: flex;
          align-items: center;

          .wt-list-search-label {
            color: var(--color-2);
            font-size: 18px;
            font-weight: 500;
            width: 40%;
            text-align: center;
            margin-right: 10px;

            @media screen and (min-width: 150px) and (max-width: 550px) {
              display: none;
            }
          }

          .wt-list-search-input {
            outline: none;
            border: none;
            width: 70%;
            background-color: var(--bg-1);
            color: var(--color-2);
            height: 40px;
            font-size: 18px;
            font-weight: 400;
            border-radius: 10px;
            padding-left: 10px;
            margin: 0;

            &::placeholder {
              font-size: 16px;
            }

            @media screen and (min-width: 150px) and (max-width: 550px) {
              height: 35px;
              width: 75%;
            }
          }

          @media screen and (min-width: 150px) and (max-width: 550px) {
            width: 70%;
            height: 100%;
          }
        }

        .wt-list-charts-link {
          border: none;
          border-radius: 15px;
          padding: 0 10px;
          background-color: var(--color-1);
          color: var(--color-2);
          width: fit-content;
          width: 95px;
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

          @media screen and (min-width: 150px) and (max-width: 550px) {
            margin-right: 0;
            margin-top: 5px;
          }
        }

        @media screen and (min-width: 150px) and (max-width: 550px) {
          height: 6em;
          align-items: inherit;
        }
      }

      .wt-accordion-content {
        background-color: var(--bg-1);
        padding: 15px 20px;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;

        .wt-list-member-table {
          .wt-list-member-header {
            .wt-list-member-header-row {
              .wt-list-member-header-cell {
                color: var(--color-2);
                font-size: 18px;
                font-weight: 500;

                &__action {
                  text-align: center;
                }
              }
            }
          }

          .wt-list-member-body {
            .wt-list-member-body-row {
              .wt-list-member-body-cell {
                color: var(--color-2);
                font-size: 18px;

                @media screen and (min-width: 150px) and (max-width: 550px) {
                  padding-left: 0;
                  padding-right: 0;
                }

                &__action {
                  text-align: center;

                  @media screen and (min-width: 150px) and (max-width: 550px) {
                    background-color: transparent;
                    width: 30px;
                  }
                }

                .wt-list-member-body-link {
                  border: none;
                  border-radius: 15px;
                  padding: 0 5px;
                  background-color: var(--color-1);
                  color: var(--color-2);
                  width: fit-content;
                  width: 75px;
                  height: 35px;
                  font-size: 16px;
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

                  @media screen and (min-width: 150px) and (max-width: 550px) {
                    background-color: transparent;
                    width: 30px;
                  }

                  .wt-list-member-body-icon {
                    display: none;

                    @media screen and (min-width: 150px) and (max-width: 550px) {
                      display: block;
                      width: 18px;
                      fill: var(--color-1);
                    }
                  }

                  .wt-list-member-body-text {
                    @media screen and (min-width: 150px) and (max-width: 550px) {
                      display: none;
                    }
                  }
                }

                .wt-list-member-body-delete {
                  border: none;
                  border-radius: 15px;
                  padding: 0 5px;
                  background-color: var(--color-3);
                  color: var(--color-2);
                  width: fit-content;
                  min-width: 60px;
                  height: 35px;
                  font-size: 16px;
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

        .wt-table-pagination-container {
          max-width: 50%;
          padding-top: 10px;
          margin-top: 10px;

          .wt-table-pagination {
            display: flex;

            .wt-table-page-item {
              display: flex;
              align-items: center;
              justify-content: center;

              .wt-table-page-link {
                color: var(--color-2);
                background-color: var(--color-1);
                font-size: 18px;
                font-weight: 400;
                border: none;
                margin-right: 10px;
                border-radius: 15px;
                width: 75px;
                height: 35px;

                &:hover {
                  cursor: pointer;
                }

                &__disabled {
                  filter: brightness(0.5);

                  &:hover {
                    cursor: not-allowed;
                  }
                }

                // @media screen and (min-width: 150px) and (max-width: 550px) {
                //   width: 52px;
                //   font-size: 12px;
                // }
              }

              .wt-table-page-link-number {
                color: var(--color-2);
                background-color: var(--color-1);
                font-size: 14px;
                font-weight: 400;
                border: none;
                margin-right: 10px;
                border-radius: 50%;
                width: 35px;
                height: 35px;

                &:hover {
                  cursor: pointer;
                }

                &__current {
                  filter: brightness(1.25);
                  border: 1px solid var(--color-2);
                }

                // @media screen and (min-width: 150px) and (max-width: 550px) {
                //   font-size: 12px;
                //   width: 26px;
                //   height: 26px;
                // }
              }
            }

            @media screen and (min-width: 150px) and (max-width: 550px) {
              margin: 0;
              width: 100%;
              padding: 0;
              justify-content: space-between;
              align-items: center;
            }
          }

          @media screen and (min-width: 150px) and (max-width: 550px) {
            margin-right: 0;
            max-width: 100%;
            width: 100%;
            padding-top: 0;
            display: flex;
          }
        }
      }

      @media screen and (min-width: 150px) and (max-width: 550px) {
        width: 95%;
        margin-left: auto;
        margin-right: auto;
        margin-bottom: 10%;
      }
    }

    .custom-calendar {
      background-color: var(--bg-4);
      border: none;
      border-radius: 10px;
      padding: 10px 30px;
      margin: 10px;

      .cell-container-cell-2 {
        border-radius: 10px !important;
        padding: 10px 10px 15px 10px !important;
        height: fit-content;
        min-height: 80px;
        margin-right: 5px;
        margin-bottom: 5px;
        background-color: var(--bg-1);

        .cell-container-cell-1 {
          background-color: var(--color-1);
          color: var(--color-2);
          height: 25px;
          width: 25px;
          border-radius: 50%;
          display: flex;
          justify-content: center;
          align-items: center;
          margin-bottom: 5px;
        }

        .cell-container-cell {
          .cell-container {
            .cell {
              color: var(--color-2);
              display: flex;
              justify-content: center;
              align-items: center;
              font-size: 14px;

              &:hover {
                color: var(--color-1);
                cursor: pointer;
              }

              .dot {
                background-color: var(--color-1);
                height: 5px;
                width: 5px;
                border-radius: 50%;
                margin-right: 5px;
                margin-top: 2px;
              }
            }
          }
        }
      }

      @media screen and (min-width: 150px) and (max-width: 850px) {
        display: none;
      }
    }

    @media screen and (min-width: 150px) and (max-width: 1300px) {
      overflow: auto;
    }
  }

  .modal-update-wt {
    position: absolute;
    z-index: 10;

    .modal-mask {
      position: fixed;
      z-index: 9998;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.75);
      display: table;
      transition: opacity 0.3s ease;

      .modal-wrapper {
        display: table-cell;
        vertical-align: middle;

        .modal-container {
          width: 350px;
          margin: 0px auto;
          padding: 20px 30px;
          background-color: var(--bg-4);
          border-radius: 10px;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
          transition: all 0.3s ease;

          .modal-body {
            margin: 20px 0;

            label {
              color: var(--color-2);
              font-size: 14px;
            }

            input[type="datetime-local"] {
              color: var(--color-2);
              font-size: 18px;

              &::-webkit-calendar-picker-indicator {
                filter: invert(100%);
              }
            }
          }

          .modal-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;

            div {
              display: flex;

              .modal-footer-button {
                border: none;
                border-radius: 10px;
                padding: 0 5px;
                background-color: var(--color-1);
                color: var(--color-2);
                width: 60px;
                height: 35px;
                font-size: 14px;
                font-weight: 400;
                text-align: center;
                display: flex;
                justify-content: center;
                align-items: center;

                &:hover {
                  filter: brightness(1.25);
                  cursor: pointer;
                }

                &__red {
                  background-color: var(--color-3);
                }

                &__green {
                  background-color: var(--color-4);
                  margin-right: 10px;
                }
              }
            }

            .modal-footer-button {
              border: none;
              border-radius: 10px;
              padding: 0 5px;
              background-color: var(--color-1);
              color: var(--color-2);
              width: 60px;
              height: 35px;
              font-size: 14px;
              font-weight: 400;
              text-align: center;
              display: flex;
              justify-content: center;
              align-items: center;

              &:hover {
                filter: brightness(1.25);
                cursor: pointer;
              }

              &__red {
                background-color: var(--color-3);
              }

              &__green {
                background-color: var(--color-4);
              }
            }
          }
        }
      }
    }
  }
}
</style>
<style src="@vueform/toggle/themes/default.css"></style>

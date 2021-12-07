<template>
  <div>
    <h2 class="p-text-center">Logs</h2>
    <InputText
      v-model="filter"
      @keyup.enter="getLogs"
      style="margin-bottom: 1rem"
      placeholder="Filter"
    />
    <InputText
      v-model="limit"
      @keyup.enter="getLogs"
      style="margin-left: 1rem; margin-bottom: 1rem"
      placeholder="Limit"
    />
    <DataTable
      :value="logs"
      responsiveLayout="scroll"
    >
      <Column
        field="log_event"
        header="Event"
      >
      </Column>
      <Column
        field="timestamp"
        header="Timestamp"
      >
      </Column>
    </DataTable>
  </div>
</template>

<script>
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";
import axios from "axios";

export default {
  name: "Logs",
  components: {
    DataTable,
    Column,
    InputText,
  },
  data() {
    return {
      logs: "",
      limit: 10,
      filter: "",
    };
  },
  created() {
    this.getLogs();
  },
  methods: {
    getLogs() {
      axios
        .get(
          `https://localhost/api/v1/logs?filter=${this.filter}&limit=${this.limit}`
        )
        .then((response) => {
          this.logs = response.data.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
};
</script>

<style lang="scss">
</style>
<template>
  <div>
    <h2 class="p-text-center">Logs</h2>
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
        field="log_timestamp"
        header="Timestamp"
      >
      </Column>
    </DataTable>
  </div>
</template>

<script>
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import axios from "axios";

export default {
  name: "Logs",
  components: {
    DataTable,
    Column,
  },
  data() {
    return {
      logs: "",
    };
  },
  created() {
    this.getLogs();
  },
  methods: {
    getLogs() {
      axios
        .get(`https://localhost/api/v1/logs/${id_user}`)
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
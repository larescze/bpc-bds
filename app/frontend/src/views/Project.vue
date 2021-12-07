<template>
  <div>
    <h2 class="p-text-center">{{ project.title }}</h2>
    <p>Duration: {{ project.duration }}</p>
    <p>Description: {{ project.description }}</p>
    <DataTable
      :value="vulnerabilities"
      responsiveLayout="scroll"
    >
      <Column
        field="vulnerablity_title"
        header="Vulnerability"
      >
      </Column>
      <Column
        field="cve"
        header="CVE"
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
  name: "Project",
  components: {
    DataTable,
    Column,
  },
  data() {
    return {
      slug: "",
      project: {
        title: "",
        duration: "",
        description: "",
      },
      vulnerabilities: null,
    };
  },
  created() {
    console.log(this.$route.params.slug);
    this.slug = this.$route.params.slug;
    if (this.slug) {
      this.getProject(this.slug);
    }
  },
  methods: {
    getProject(slug) {
      axios
        .get(`https://localhost/api/v1/project/${slug}`)
        .then((response) => {
          this.project = response.data.project;
          this.vulnerabilities = response.data.data;
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
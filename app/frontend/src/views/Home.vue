<template>
  <div>
    <h2 class="p-text-center">Projects</h2>
    <div class="card">
      <DataTable
        ref="dt"
        :value="projects"
        v-model:selection="selectedProjects"
        dataKey="slug"
        :paginator="true"
        :rows="10"
        :filters="filters"
        paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
        :rowsPerPageOptions="[5,10,25]"
        currentPageReportTemplate="Showing {first} to {last} of {totalRecords} projects"
        responsiveLayout="scroll"
        selectionMode="single"
        @rowSelect="onRowSelect"
      >
        <template #header>
          <div class="table-header p-d-flex p-flex-column p-flex-md-row p-jc-md-between">
            <span class="p-input-icon-left">
              <i class="pi pi-search" />
              <InputText
                v-model="filters['global'].value"
                placeholder="Search..."
              />
            </span>
            <Button
              label="New"
              icon="pi pi-plus"
              class="p-button-success p-mr-2"
              @click="openNew"
            />
          </div>
        </template>
        <Column
          field="title"
          header="Name"
          :sortable="true"
          style="min-width:16rem"
        >
        </Column>
        <Column
          field="description"
          header="Description"
          :sortable="true"
          style="min-width:8rem"
        >
        </Column>
        <Column
          field="start_date"
          header="Project starts"
          :sortable="true"
          style="min-width:10rem"
        >
        </Column>
        <Column
          field="end_date"
          header="Deadline"
          :sortable="true"
          style="min-width:12rem"
        >
        </Column>
        <Column
          :exportable="false"
          style="min-width:8rem"
        >
          <template #body="slotProps">
            <div class="options">
              <Button
                icon="pi pi-pencil"
                class="p-button-rounded p-button-success p-mr-2"
                @click="editProject(slotProps.data)"
              />
              <Button
                icon="pi pi-trash"
                class="p-button-rounded p-button-warning"
                @click="confirmDeleteProject(slotProps.data)"
              />
            </div>
          </template>
        </Column>
      </DataTable>
    </div>
    <Dialog
      v-model:visible="projectDialog"
      :style="{width: '450px'}"
      header="Project Details"
      :modal="true"
      class="p-fluid"
    >
      <div class="p-field">
        <label for="slug">Slug</label>
        <InputText
          id="slug"
          v-model.trim="project.slug"
          required="true"
          autofocus
          :class="{'p-invalid': submitted && !project.slug}"
        />
        <small
          class="p-error"
          v-if="submitted && !project.slug"
        >
          Slug is required.
        </small>
      </div>
      <div class="p-field">
        <label for="title">Name</label>
        <InputText
          id="title"
          v-model.trim="project.title"
          required="true"
          autofocus
          :class="{'p-invalid': submitted && !project.title}"
        />
        <small
          class="p-error"
          v-if="submitted && !project.title"
        >
          Name is required.
        </small>
      </div>
      <div class="p-field">
        <label for="start_date">Project starts</label>
        <InputText
          id="start_date"
          v-model.trim="project.start_date"
          required="true"
          autofocus
          :class="{'p-invalid': submitted && !project.start_date}"
        />
        <small
          class="p-error"
          v-if="submitted && !project.start_date"
        >
          Project start date is required.
        </small>
      </div>
      <div class="p-field">
        <label for="end_date">Deadline</label>
        <InputText
          id="end_date"
          v-model.trim="project.end_date"
          required="true"
          autofocus
          :class="{'p-invalid': submitted && !project.end_date}"
        />
        <small
          class="p-error"
          v-if="submitted && !project.end_date"
        >
          Deadline is required.
        </small>
      </div>
      <div class="p-field">
        <label for="description">Description</label>
        <Textarea
          id="description"
          v-model="project.description"
          required="true"
          rows="3"
          cols="20"
        />
      </div>
      <template #footer>
        <Button
          label="Cancel"
          icon="pi pi-times"
          class="p-button-text"
          @click="hideDialog"
        />
        <Button
          label="Save"
          icon="pi pi-check"
          class="p-button-text"
          @click="saveProject"
        />
      </template>
    </Dialog>
    <Dialog
      v-model:visible="deleteProjectDialog"
      :style="{width: '450px'}"
      header="Confirm"
      :modal="true"
    >
      <div class="confirmation-content">
        <i
          class="pi pi-exclamation-triangle p-mr-3"
          style="font-size: 2rem"
        />
        <span v-if="project">Are you sure you want to delete <b>{{project.title}}</b>?</span>
      </div>
      <template #footer>
        <Button
          label="No"
          icon="pi pi-times"
          class="p-button-text"
          @click="deleteProjectDialog = false"
        />
        <Button
          label="Yes"
          icon="pi pi-check"
          class="p-button-text"
          @click="deleteProject"
        />
      </template>
    </Dialog>

    <Dialog
      v-model:visible="deleteProjectsDialog"
      :style="{width: '450px'}"
      header="Confirm"
      :modal="true"
    >
      <div class="confirmation-content">
        <i
          class="pi pi-exclamation-triangle p-mr-3"
          style="font-size: 2rem"
        />
        <span v-if="project">Are you sure you want to delete the selected projects?</span>
      </div>
      <template #footer>
        <Button
          label="No"
          icon="pi pi-times"
          class="p-button-text"
          @click="deleteProjectsDialog = false"
        />
        <Button
          label="Yes"
          icon="pi pi-check"
          class="p-button-text"
          @click="deleteSelectedProjects"
        />
      </template>
    </Dialog>
  </div>
</template>

<script>
import Dialog from "primevue/dialog";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";
import Textarea from "primevue/textarea";
import Button from "primevue/button";
import { FilterMatchMode } from "primevue/api";
import axios from "axios";

export default {
  name: "Home",
  components: {
    Dialog,
    DataTable,
    Column,
    InputText,
    Textarea,
    Button,
  },
  data() {
    return {
      columns: null,
      project: null,
      projects: null,
      selectedProjects: null,
      projectDialog: false,
      deleteProjectDialog: false,
      deleteProjectsDialog: false,
      editingRows: [],
    };
  },
  created() {
    this.columns = [
      { field: "title", header: "Name" },
      { field: "description", header: "Description" },
      { field: "start_date", header: "Start date" },
      { field: "end_date", header: "Deadline" },
    ];
    this.initFilters();
  },
  mounted() {
    this.getProjects();
  },
  methods: {
    getProjects() {
      axios
        .get("https://localhost/api/v1/projects")
        .then((response) => {
          this.projects = response.data.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    onRowSelect(event) {
      this.$router.push({
        name: "Project",
        params: {
          slug: event.data.slug,
        },
      });
    },
    openNew() {
      this.project = {};
      this.submitted = false;
      this.projectDialog = true;
    },
    hideDialog() {
      this.projectDialog = false;
      this.submitted = false;
    },
    saveProject() {
      this.submitted = true;
      console.log(this.project);
      if (this.project.title.trim()) {
        if (this.project.id_project) {
          axios
            .put(
              `https://localhost/api/v1/projects/${this.project.slug}`,
              this.project
            )
            .then((response) => {
              this.$toast.add({
                severity: "success",
                summary: "Successful",
                detail: "Project updated",
                life: 3000,
              });
            })
            .catch((error) => {
              console.log(error);
            });
        } else {
          axios
            .post(`https://localhost/api/v1/projects`, this.project)
            .then((response) => {
              this.$toast.add({
                severity: "success",
                summary: "Successful",
                detail: "Project created",
                life: 3000,
              });
            })
            .catch((error) => {
              console.log(error);
            });
        }
        this.projectDialog = false;
        this.project = {};
        this.getProjects();
      }
    },
    editProject(project) {
      this.project = { ...project };
      this.projectDialog = true;
    },
    confirmDeleteProject(project) {
      this.project = project;
      this.deleteProjectDialog = true;
    },
    deleteProject() {
      axios
        .delete(`https://localhost/api/v1/projects/${this.project.slug}`)
        .then((response) => {
          this.$toast.add({
            severity: "success",
            summary: "Successful",
            detail: "Project deleted",
            life: 3000,
          });
        })
        .catch((error) => {
          console.log(error);
        });
      this.deleteProjectDialog = false;
      this.project = {};
      this.getProjects();
    },
    initFilters() {
      this.filters = {
        global: { value: null, matchMode: FilterMatchMode.CONTAINS },
      };
    },
  },
};
</script>

<style lang="scss">
th,
td {
  padding-left: 1rem !important;
}

.table-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.p-button {
  background: #f15a24 !important;
  color: #fff !important;
}

.options {
  display: flex;
  gap: 0.75rem;
}

.p-dialog-content {
  .p-field,
  .p-component {
    margin-top: 0.75rem;
  }
}
</style>
<template>
  <div class="form">
    <h2 class="p-text-center">Log in to Pentesting App</h2>
    <form
      @submit.prevent="handleSubmit(!v$.$invalid)"
      class="p-fluid"
    >
      <div class="p-field">
        <div class="p-float-label p-input-icon-right">
          <i class="pi pi-envelope" />
          <InputText
            id="email"
            v-model="v$.email.$model"
            :class="{'p-invalid':v$.email.$invalid && submitted}"
            aria-describedby="email-error"
          />
          <label
            for="email"
            :class="{'p-error':v$.email.$invalid && submitted}"
          >
            Email*
          </label>
        </div>
        <span v-if="v$.email.$error && submitted">
          <span
            id="email-error"
            v-for="(error, index) of v$.email.$errors"
            :key="index"
          >
            <small class="p-error">{{error.$message}}</small>
          </span>
        </span>
        <small
          v-else-if="(v$.email.$invalid && submitted) || v$.email.$pending.$response"
          class="p-error"
        >
          {{v$.email.required.$message.replace('Value', 'Email')}}
        </small>
      </div>
      <div class="p-field">
        <div class="p-float-label">
          <Password
            id="password"
            v-model="v$.password.$model"
            :class="{'p-invalid':v$.password.$invalid && submitted}"
            :feedback="false"
            :autocomplete="true"
            toggleMask
          >
          </Password>
          <label
            for="password"
            :class="{'p-error':v$.password.$invalid && submitted}"
          >
            Password*
          </label>
        </div>
        <small
          v-if="(v$.password.$invalid && submitted) || v$.password.$pending.$response"
          class="p-error"
        >
          {{v$.password.required.$message.replace('Value', 'Password')}}
        </small>
        <small
          v-if="serverError"
          class="p-error"
        >
          {{ serverError }}
        </small>
      </div>
      <Button
        type="submit"
        label="Submit"
        class="p-mt-2"
      />
    </form>
  </div>
</template>

<script>
import InputText from "primevue/inputtext";
import Password from "primevue/password";
import Button from "primevue/button";
import { email, required } from "@vuelidate/validators";
import { useVuelidate } from "@vuelidate/core";
import axios from "axios";

export default {
  name: "Login",
  components: {
    InputText,
    Password,
    Button,
  },
  setup: () => ({ v$: useVuelidate() }),
  data() {
    return {
      email: "",
      password: "",
      submitted: false,
      showMessage: false,
      serverError: "",
    };
  },
  validations() {
    return {
      email: {
        required,
        //email,
      },
      password: {
        required,
      },
    };
  },
  methods: {
    handleSubmit(isFormValid) {
      this.submitted = true;

      if (!isFormValid) {
        return;
      }

      axios
        .post("http://localhost:8000/api/v1/token/login", {
          username: this.email,
          password: this.password,
        })
        .then((response) => {
          const token = response.data.auth_token;
          this.$store.commit("setToken", token);
          axios.defaults.headers.common["Authorization"] = "Token " + token;
          localStorage.setItem("token", token);
          this.$router.push({ name: "Home" });
        })
        .catch((error) => {
          this.serverError = error.response.data.non_field_errors[0];
          this.$store.commit("removeToken");
        });
    },
    resetForm() {
      this.email = "";
      this.password = "";
      this.submitted = false;
    },
  },
};
</script>

<style lang="scss" scoped>
.form {
  margin: 0 auto;
  max-width: 400px;

  form {
    margin-top: 2rem;
  }

  .p-field {
    margin-bottom: 1.5rem;
  }

  .p-error {
    display: block;
    margin-top: 0.5rem;
  }

  .p-button {
    color: #fff;
    background: #f15a24;
  }

  @media screen and (max-width: 960px) {
    .form {
      width: 80%;
    }
  }
}
</style>
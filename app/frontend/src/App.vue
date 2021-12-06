<template>
  <div>
    <header>
      <div class="logo">
        <img
          src="./assets/logo.png"
          alt="Logo"
          width="32"
        >
        <div>BPC-BDS - Pentesting</div>
      </div>
      <div id="nav">
        <template v-if="$store.state.isAuthenticated">
          <router-link to="/">Home</router-link> |
          <router-link to="/about">About</router-link> |
          <span
            as="button"
            @click="logout"
          >
            Logout
          </span>
        </template>
        <template v-else>
          <router-link to="/login">Login</router-link>
        </template>
      </div>
    </header>
    <main>
      <div class="container">
        <router-view />
      </div>
    </main>
    <footer>
      <p>Code &amp; design by Willi Lazarov</p>
      <a href="https://github.com/larescze/bpc-bds-xlazar15">
        <i
          class="pi pi-github"
          style="fontSize: 2rem"
        ></i>
      </a>
    </footer>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "App",
  beforeCreate() {
    this.$store.commit("initializeStore");
    const token = this.$store.state.token;
    if (token) {
      axios.defaults.headers.common["Authorization"] = "Token " + token;
    } else {
      axios.defaults.headers.common["Authorization"] = "";
      this.$router.push({ name: "Login" });
    }
  },
  methods: {
    logout() {
      this.$store.commit("removeToken");
      this.$router.push({ name: "Login" });
    },
  },
};
</script>

<style lang="scss">
body {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background: #151515;
  color: #fff;
}

header {
  margin-top: 1rem;
  text-align: center;

  .logo {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 0.5rem;
    font-size: 1.25em;
    font-weight: 600;
  }
}

footer {
  margin: 1.25rem 18rem;
  padding: 1rem;
  // border-top: 1px solid silver;
  text-align: center;

  @media (max-width: 1600px) {
    margin: 1.25rem 8rem;
  }
}

h1,
h2,
h3 {
  text-align: center;
}

a {
  font-weight: bold;
  color: #fff;

  &.router-link-exact-active {
    color: #f15a24;
  }
}

#nav {
  margin: 0 18rem;
  padding: 1.25rem 0;
  border-bottom: 1px solid silver;

  @media (max-width: 1600px) {
    margin: 0 8rem;
  }
}

.container {
  padding: 0 18rem;
  width: 100%;
  text-align: justify;
  hyphens: auto;

  @media (max-width: 1600px) {
    padding: 0 8rem;
  }
}
</style>

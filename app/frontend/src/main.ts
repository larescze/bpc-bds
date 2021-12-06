import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import axios from 'axios';
import store from './store';
import PrimeVue from 'primevue/config';
import 'primevue/resources/themes/mdc-dark-indigo/theme.css'
import 'primevue/resources/primevue.min.css';
import "primeicons/primeicons.css";

axios.defaults.baseURL = "https://localhost";

const app = createApp(App);

app.use(router, axios);
app.use(store);
app.use(PrimeVue);
app.mount('#app')

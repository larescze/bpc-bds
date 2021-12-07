import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import Home from '../views/Home.vue';
import Project from '../views/Project.vue';
import Login from '../views/Login.vue';
import About from '../views/About.vue';
import Logs from '../views/Logs.vue';

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'Home',
    component: Home,
  },
  {
    path: '/:slug',
    name: 'Project',
    component: Project,
  },
  {
    path: '/login',
    name: 'Login',
    component: Login,
  },
  {
    path: '/about',
    name: 'About',
    component: About,
  },
  {
    path: '/try-to-hack-me',
    name: 'Logs',
    component: Logs,
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router

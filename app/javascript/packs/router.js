import Vue from 'vue'
import VueRouter from 'vue-router';
import Restaurants from '../components/pages/restaurants/Index.vue'

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    component: Restaurants,
    name: 'Restaurants'
  },
];

export default new VueRouter({ routes });
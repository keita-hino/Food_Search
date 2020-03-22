import Vue from 'vue'
import VueRouter from 'vue-router';
import Restaurants from '../components/restaurants/Index.vue'
// import ProjectCreate from '../components/project_create.vue'
// import ProjectUpdate from '../components/project_update.vue'
// import ChildFeeCreate from '../components/child_fee_create.vue'
// import ChildFeeUpdate from '../components/child_fee_update.vue'

Vue.use(VueRouter);

const routes = [
  { path: '/', component: Restaurants, name: 'Restaurants' },
  // { path: '/projects/new', component: ProjectCreate, name: ProjectCreate },
  // { path: '/projects/:id/edit', component: ProjectUpdate, name: 'ProjectUpdate' },
  // { path: '/child_fees/new', component: ChildFeeCreate, name: ChildFeeCreate },
  // { path: '/child_fees/:id/edit', component: ChildFeeUpdate, name: 'ChildFeeUpdate' }
];

export default new VueRouter({ routes });
<template>
  <v-app id="inspire">
    <Header/>
    <div class="container">
      <router-view/>
    </div>
    <SideIcon/>
  </v-app>
</template>

<script>
  import Header from './components/layouts/Header'
  import SideIcon from './components/layouts/SideIcon'
  export default {
    data: function () {
      return {
        message: "vue.js動いたぞ"
      }
    },

    components: {
      Header,
      SideIcon
    },

  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>

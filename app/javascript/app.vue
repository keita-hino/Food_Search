<template>
  <v-app id="inspire">
    <Header/>
    <div class="container">
      <router-view/>
    </div>
  </v-app>
</template>

<script>
  import Header from './components/layouts/Header'
  export default {
    data: function () {
      return {
        message: "vue.js動いたぞ"
      }
    },

    components: {
      Header
    },

  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>

<template>
  <div id="app">
    <!-- <Header/> -->
    <div class="container">
      <router-view/>
    </div>
  </div>
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

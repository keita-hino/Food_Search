<template>
  <div id="app" class="container">
    <router-view/>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "vue.js動いたぞ"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

import Vue from 'vue'
import VueScrollTo from 'vue-scrollto'

Vue.use(VueScrollTo);

const scrollto = {
  /* オプション色々あります。公式サイトから確認できます。 */
  duration: 1000,
  easing: "ease"
};

export default new VueScrollTo({ scrollto });
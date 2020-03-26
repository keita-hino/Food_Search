<template>
  <v-content>
    <v-container>
      <v-row
        v-scroll="onScroll"
        class="lighten-4"
        justify="center" align-content="start"
      >
        <div id="top" class='headline font-italic font-weight-bold'>MY STORES</div>
      </v-row>
        <Loading v-show="is_loading"></Loading>
        <template v-if="!is_loading">
          <v-card class="mt-4 mb-4 pa-3">
            <v-layout row wrap>
            <v-flex xs12 md4 v-for="restaurant in restaurants" :key="restaurant.id">
              <v-card
                :color="'#FFFFFF'"
                class="lighten-3 ma-2"
                max-width="400"
              >
                <v-img
                  class="white--text align-end"
                  height="200px"
                  :src="restaurant.image_url"
                >
                  <v-card-title
                    :color="'#FFFFFF'"
                  >
                    {{ restaurant.name}}
                  </v-card-title>
                </v-img>

                <v-card-subtitle
                class="pb-0"
                :color="'#FFFFFF'"
                >
                住所
                </v-card-subtitle>

                <!-- 住所が長い時は省略したものを表示 -->
                <template v-if="!!restaurant.short_address" >
                  <v-card-text :color="'#FFFFFF'" class="text--primary">
                    <v-tooltip top>
                      <template v-slot:activator="{ on }">
                          <div v-on="on">{{ getAddress(restaurant) }}</div>
                          </template>
                      <span>{{ restaurant.address }}</span>
                    </v-tooltip>
                  </v-card-text>
                </template>
                <template v-else>
                  <v-card-text :color="'#FFFFFF'" class="text--primary">
                    <div>{{ restaurant.address }}</div>
                  </v-card-text>
                </template>

                <v-card-subtitle :color="'#FFFFFF'" class="pb-0">営業時間</v-card-subtitle>

                <!-- 営業時間が長い時は省略したものを表示 -->
                <template v-if="!!restaurant.short_open_info" >
                  <v-card-text :color="'#FFFFFF'" class="text--primary">
                    <v-tooltip top>
                      <template v-slot:activator="{ on }">
                          <div v-on="on">{{ getOpenInfo(restaurant) }}</div>
                          </template>
                      <span>{{ restaurant.open_info }}</span>
                    </v-tooltip>
                  </v-card-text>
                </template>
                <template v-else>
                  <v-card-text :color="'#FFFFFF'" class="text--primary">
                    <div>{{ restaurant.open_info }}</div>
                  </v-card-text>
                </template>

                <v-card-actions>
                  <v-spacer>
                    <v-btn
                    color="orange"
                    text
                    :href="restaurant.site_url"
                  >
                    サイトへ
                  </v-btn>

                  </v-spacer>

                  <v-btn icon>
                    <v-tooltip top>
                      <template v-slot:activator="{ on }">
                        <i v-on="on" @click.stop="openModal(restaurant.id)" class="material-icons">delete</i>
                      </template>
                      <span>削除する</span>
                    </v-tooltip>
                  </v-btn>

                </v-card-actions>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
      </template>

    <!-- 右下のアイコン -->
    <transition name="fade">
      <div v-if="isShowTopButton" class="fixed-action-btn">
        <a class="btn-floating btn-large red">
          <i v-scroll-to="toTop" class="large material-icons">expand_less</i>
        </a>
      </div>
    </transition>

    <v-dialog v-model="dialog" persistent max-width="290">
      <v-card>
        <v-card-title class="headline">削除確認</v-card-title>
        <v-card-text>本当に削除してもよろしいですか？</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" text @click.stop="dialog = false">キャンセル</v-btn>
          <v-btn color="green darken-1" text @click.stop="deleteRestaurant()">OK</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- TODO:別コンポーネントに -->
    <!-- 削除完了モーダル -->
      <v-dialog
        v-model="is_show_complate_dialog"
        max-width="290"
      >
        <v-card>
          <v-card-title class="headline">完了</v-card-title>

          <v-card-text>
            削除完了しました。
          </v-card-text>

          <v-card-actions>
            <!-- 下記で右寄せできる -->
            <v-spacer></v-spacer>
            <v-btn
              color="green darken-1"
              text
              @click.stop="closeComplateModal()"
            >
              OK
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>

    </v-container>
  </v-content>
</template>

<script>
  // Ajax通信ライブラリ
  import axios from 'axios';
  import Loading from '../common/Loading'

  // TODO:axiosをここでimportするんじゃなくて、application.jsでimportするようにする。
  // 下記の設定もそこで
  axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  };

  export default {
    data: function () {
      return {
        restaurants: [],
        is_fetch_complate: true,
        is_show_complate_dialog: false,
        dialog: false,
        is_loading: true,
        offsetTop: 0,
        toTop: '#top',
        form: {
          name: '',
          address: '',
        }
      }
    },

    components: {
      Loading
    },

    methods: {
      // 登録されているお店を取得する
      getRestaurants: function(){
        axios.get('api/v1/restaurants.json')
          .then(response => {
            this.restaurants = response.data.restaurants
          });
      },

      // 該当のお店を削除する
      deleteRestaurant() {
        axios.delete(`api/v1/restaurants/${this.delete_restaurant_id}.json`)
          .then(response => {
            // モーダルを閉じる
            this.dialog = false
            // 完了モーダルを表示
            this.is_show_complate_dialog = true;
          });
      },

      // 削除完了モーダルを閉じて、画面をリロードする
      closeComplateModal() {
        // 完了モーダルを閉じる
        this.is_show_complate_dialog = false;
        // ローディングを表示
        this.is_loading = true;
        // 画面リロード
        this.$router.go({path: this.$router.currentRoute.path, force: true});
      },

      // 営業時間が長ければ、省略したものを返す
      getAddress(restaurant) {
        return !!restaurant.short_address ? restaurant.short_address : restaurant.address
      },

      // 営業時間が長ければ、省略したものを返す
      getOpenInfo(restaurant) {
        return !!restaurant.short_open_info ? restaurant.short_open_info : restaurant.open_info
      },

      // モーダルを開く
      // モーダルをv-forの外に出しているため、idを一時的に格納する
      openModal(id){
        this.delete_restaurant_id = id;
        this.dialog = true;
      },

      // スクロールされた時
      onScroll (e) {
        this.offsetTop = window.pageYOffset || document.documentElement.scrollTop
      },

      // ページ上部へ移動
      onClickGotoPageTop() {
            const duration = 1000;  // 移動速度（1秒で終了）
            const interval = 25;    // 0.025秒ごとに移動
            const step = -window.scrollY / Math.ceil(duration / interval); // 1回に移動する距離
            const timer = setInterval(() => {

                window.scrollBy(0, step);   // スクロール位置を移動

                if(window.scrollY <= 0) {

                    clearInterval(timer);

                }

            }, interval);
      },
    },

    mounted: function(){
      this.getRestaurants();
      this.is_loading = false;
    },

    computed: {
      isShowTopButton() {
        return this.offsetTop > 100
      }
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }

  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s;
  }
  .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0;
  }
</style>

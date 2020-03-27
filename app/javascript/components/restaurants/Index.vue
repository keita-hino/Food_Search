<template>
  <v-content>
    <v-container>
      <v-row
        v-scroll="onScroll"
        class="lighten-4"
        justify="center" align-content="start"
      >
        <div id="top" class='headline font-italic font-weight-light'>MY STORES</div>
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

                  <!-- シェアボタン -->
                  <v-btn icon>
                    <v-tooltip top>
                      <template v-slot:activator="{ on }">
                        <i v-on="on" @click.stop="onClickShareDialog(restaurant.id)" class="material-icons">share</i>
                      </template>
                      <span>シェアする</span>
                    </v-tooltip>
                  </v-btn>

                  <!-- 削除ボタン -->
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

    <!-- シェア確認モーダル -->
    <v-dialog v-model="is_show_share_confirm_dialog" persistent max-width="290">
      <v-card>
        <v-card-title class="headline">シェア確認</v-card-title>
        <v-card-text>本当にシェアしてもよろしいですか？</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" text @click.stop="is_show_share_confirm_dialog = false">キャンセル</v-btn>
          <v-btn color="green darken-1" text @click.stop="shareRestaurant()">OK</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- 削除確認モーダル -->
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

      <!-- シェア完了モーダル -->
      <v-dialog
        v-model="is_show_share_complate_dialog"
        max-width="290"
      >
        <v-card>
          <v-card-title class="headline">完了</v-card-title>

          <v-card-text>
            シェアしました。
          </v-card-text>

          <v-card-actions>
            <!-- 下記で右寄せできる -->
            <v-spacer></v-spacer>
            <v-btn
              color="green darken-1"
              text
              @click.stop="is_show_share_complate_dialog = false"
            >
              OK
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>


    <!-- シェア相手選択用モーダル -->
    <v-dialog
      v-model="is_show_share_dialog"
      max-width="500"

    >
      <v-card>
        <v-card-title class="headline">シェアする相手を選んでください</v-card-title>

        <v-card-text>

          <div v-for="user in users" :key="user.name">
            <v-avatar>
              <img
                :src="user.url"
                alt="John"
                @click="onClickShareConfirm(user)"
              >
            </v-avatar>
          </div>

        </v-card-text>

        <v-card-actions>
          <v-spacer></v-spacer>

          <v-btn
            color="green darken-1"
            text
            @click="is_show_share_dialog = false"
          >
            閉じる
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
        users: [],
        is_fetch_complate: true,
        is_show_complate_dialog: false,
        is_show_share_dialog: false,
        is_show_share_confirm_dialog: false,
        is_show_share_complate_dialog: false,
        dialog: false,
        is_loading: true,
        selected_user: {},
        selected_restaurant_id: '',
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
            this.users = response.data.users
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

      // 該当のお店をシェアする
      shareRestaurant() {
        axios.post(`api/v1/restaurants/share.json`, {
          user: this.selected_user,
          restaurant_id: this.selected_restaurant_id
        })
        .then(response => {
          // モーダルを閉じる
          this.is_show_share_confirm_dialog = false
          // 完了モーダルを開く
          this.is_show_share_complate_dialog = true
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

      // シェアモーダル
      onClickShareDialog(id) {
        this.selected_restaurant_id = id
        this.is_show_share_dialog = true
      },

      // シェア確認用モーダル
      onClickShareConfirm(user) {
        this.selected_user = user
        this.is_show_share_confirm_dialog = true
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

  .image-radio-button {
            text-align: center;
            border:1px solid #ccc;
            border-radius: 5px;
            margin-right: 20px;
            padding: 10px;
            float: left;
  }
  .image-radio-button:hover {
      background: #eee;
  }
  .image-radio-button img {
      height: 150px;
      margin-top: 10px;
  }
  .image-radio-button label {
      cursor: pointer;
  }
</style>

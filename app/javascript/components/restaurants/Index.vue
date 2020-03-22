<template>
  <v-app id="restaurants">
    <v-content>
      <v-container>
        <v-row
          class="lighten-4"
          justify="center" align-content="start"
        >
          <div class='display-2 font-weight-regular	'>お店一覧</div>
        </v-row>

        <!-- モーダル -->
        <!-- TODO:あとで別コンポーネントに -->
        <!-- <v-dialog v-model="dialog" persistent max-width="600px">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark v-on="on">お店登録</v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">お店登録</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="form.name" label="店名" required></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="form.address" label="Legal middle name" hint="住所"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      label="Legal last name*"
                      hint="example of persistent helper text"
                      persistent-hint
                      required
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field label="Email*" required></v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field label="Password*" type="password" required></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6">
                    <v-select
                      :items="['0-17', '18-29', '30-54', '54+']"
                      label="Age*"
                      required
                    ></v-select>
                  </v-col>
                  <v-col cols="12" sm="6">
                    <v-autocomplete
                      :items="['Skiing', 'Ice hockey', 'Soccer', 'Basketball', 'Hockey', 'Reading', 'Writing', 'Coding', 'Basejump']"
                      label="Interests"
                      multiple
                    ></v-autocomplete>
                  </v-col>
                </v-row>
              </v-container>
              <small>*indicates required field</small>
            </v-card-text>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="dialog = false">Close</v-btn>
              <v-btn color="blue darken-1" text @click="dialog = false">Save</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog> -->
        <!-- ここまで -->
          <v-card class="mt-4 mb-4 pa-3">
            <v-layout row wrap>
            <v-flex xs12 md4 v-for="restaurant in restaurants" :key="restaurant.id">
              <v-card
                :color="'#FFFFFF'"
                :loading="restaurant.is_fetch"
                class="lighten-3 ma-2"
                max-width="400"
                :href="restaurant.site_url"
                height="450"
                hover="true"
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

                <v-card-text :color="'#FFFFFF'" class="text--primary">
                  <div>{{ restaurant.address }}</div>
                </v-card-text>

                <v-card-subtitle :color="'#FFFFFF'" class="pb-0">営業時間</v-card-subtitle>

                <v-card-text :color="'#FFFFFF'" class="text--primary">
                  <div>{{ restaurant.open_info }}</div>
                </v-card-text>

                <v-card-actions>
                  <v-btn
                    color="orange"
                    text
                  >
                    サイトへ
                  </v-btn>
                </v-card-actions>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>

      </v-container>
    </v-content>
  </v-app>
</template>

<script>
// Ajax通信ライブラリ
import axios from 'axios';

export default {
  data: function () {
    return {
      restaurants: [],
      is_fetch_complate: true,
      dialog: false,
      form: {
        name: '',
        address: '',
      }
    }
  },
  methods: {
    setRestaurants: function(){
      axios.get('api/v1/restaurants.json')
        .then(response => {
          for(var i = 0; i < response.data.restaurants.length; i++) {
            this.restaurants.push(response.data.restaurants[i])
            this.restaurants[i].is_fetch = false;
          }
        });
    }
  },
  mounted: function(){
    this.setRestaurants();
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

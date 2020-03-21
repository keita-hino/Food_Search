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
          <v-card class="mt-4 mb-4 pa-3">
            <v-layout row wrap>
            <v-flex xs4 v-for="restaurant in restaurants" :key="restaurant.id">
              <v-card
                :color="'#FFFFFF'"
                :loading="restaurant.is_fetch"
                class="lighten-3 ma-2"
                max-width="400"
                :href="restaurant.site_url"
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

        <!-- <div class="col s12 l4 m6">
          <div class="card hoverable">
            <div class="row">
              <div v-for="restaurant in restaurants" :key="restaurant.id">
                <div class="card-image">
                  <img :src="restaurant.image_url">
                  <span class="card-title">{{restaurant.name}}</span>
                </div>
                <div class="card-content">
                  <p>住所</p>
                  {{ restaurant.address }}<br>
                  <p>営業時間</p>
                  {{ restaurant.open_info }}<br>
                </div>
                <div class="card-action">
                  サイトへ
                  {{ restaurant.open_info }}<br>
                </div>
              </div>
            </div>
          </div>
        </div> -->


    <!--
      <th><router-link :to="{name: 'ProjectUpdate', params: {id: project.id}}" class="btn btn-info">編集</router-link></th>

    <% @restaurants.each do |restaurant| %>
      <div class="card-image">
        <%= image_tag(restaurant.image_url, size: '400x300')%>
        <span class="card-title"><%= restaurant.name%></span>
      </div>
      <div class="card-content">
        <p>住所</p>
        <%= restaurant.address%><br>
        <p>営業時間</p>
        <%= restaurant.open_info%>
      </div>
      <div class="card-action">
        <%= link_to "サイトへ", restaurant&.site_url %>
      </div>
    <%end%>
  </div>
 -->
    <!-- <p>{{ restaurants }}</p> -->
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
      is_fetch_complate: true
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

<template>
  <div id="restaurants">
    <h3 class='center-align'>お店一覧</h3>
    <div class="col s12 l4 m6">
      <div class="card hoverable">
        <div class="row">
          <div v-for="restaurant in restaurants" :key="restaurant.id">
            <div class="card-image">
              <img src='{{restaurant.image_url}}'>
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
    </div>
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
  <!-- </div> -->
</template>

<script>
// Ajax通信ライブラリ
import axios from 'axios';

export default {
  data: function () {
    return {
      restaurants: []
    }
  },
  methods: {
    setRestaurants: function(){
      axios.get('api/v1/restaurants.json')
        .then(response => {
          for(var i = 0; i < response.data.restaurants.length; i++) {
            this.restaurants.push(response.data.restaurants[i])
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

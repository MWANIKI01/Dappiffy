<template>
  <nav class="navbar">
    <div class="nav-item">
      <router-link to="/">Profile</router-link> 
    </div>
    <div class="nav-item">
      <router-link to="/">Home</router-link> 
    </div>
    <div class="nav-item">
      <router-link to="/">Updates</router-link> 
    </div>
    <div class="nav-item">
      <router-link to="/">dApp Registration</router-link>
    </div>
    <div class="nav-item">
      <router-link to="/">Login</router-link>
    </div>
    <div class="nav-item">
      <router-link to="/">Sign up</router-link>
    </div>
  </nav>
  <router-view/>   
</template>

<script>
export default {
  name: 'navbar',
  // props: {
  //   msg: String
  // }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.navbar {
  display: flex;
  justify-content: space-around;
  align-items: center;
  padding: 10px 0;
  background-color: #333;
  color: #fff;
  top: o;
  width: 10;
}

.nav-item {
  margin: 0 10px;
}

.nav-item a {
  font-weight: bold;
  color: #fff;
  text-decoration: none;
}

.nav-item a:hover {
  color: #42b983;
}
</style>

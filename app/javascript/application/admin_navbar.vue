<template>
  <ul class="navbar-nav mr-auto">
    <li class="nav-item">
      <a href="/admin_dashboard" v-bind:class="{ active: currentPage === '/admin_dashboard' }" class="nav-link">Admin Dashboard</a>
    </li>
    <li class="nav-item">
      <a href="/admin/users" v-bind:class="{ active: currentPage === '/admin/users' }" class="nav-link">Users</a>
    </li>
    <li class="nav-item">
      <a href="/admin/appointments" v-bind:class="{ active: currentPage === '/admin/appointments' }" class="nav-link">Appointments</a>
    </li>
  </ul>
</template>
<script>
  export default {
    props: ['currentPage']
  }
</script>

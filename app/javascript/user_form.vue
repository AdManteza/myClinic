<template>
  <div>
    <b-btn v-b-modal.userForm variant="primary">Add a new user</b-btn>

    <!-- Modal Component -->
    <b-modal id="userForm"
             ref="modal"
             title="New User"
             @ok="handleOk">
      <form @submit.stop.prevent="handleSubmit">
        <b-form-input type="text" placeholder="Enter your name"></b-form-input>
      </form>
    </b-modal>
  </div>
</template>

<script>
  export default {
    methods: {
      handleOk (event) {
        event.preventDefault()
        debugger
        params = {
          username: 'DUH',
          firstname: 'Fname',
          lastname: 'Lname',
          password: 'pw'
        }

        this.$http.post('/admin/users.json', params).then(response => {
          console.log(response)
          // get body data
          this.someData = response.body;

        }, response => {
          // error callback
        });

      },
      handleSubmit () {
        console.log(this);
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

<template>
  <div>
    <b-btn @click="showModal" variant="primary">Add a new user</b-btn>
    <!-- Modal Component -->
    <b-modal id="userForm" ref="modal" title="New User" @ok="handleOk">
      <form @submit.stop.prevent="handleSubmit">
        <b-form-group
          horizontal
          label="Username"
          label-for="username"
          :state="username_state"
        >
          <b-form-input id="username" :state="username_state" v-model="username" trim/>
        </b-form-group>

        <b-form-group
          horizontal
          label="First Name"
          label-for="firstname"
          :state="firstname_state"
        >
          <b-form-input id="firstname" :state="firstname_state" v-model="firstname" trim/>
        </b-form-group>

        <b-form-group
          horizontal
          label="Last Name"
          label-for="lastname"
          :state="lastname_state"
        >
          <b-form-input id="lastname" :state="lastname_state" v-model="lastname" trim/>
        </b-form-group>

        <b-form-group
          horizontal
          label="Password"
          label-for="password"
          :state="password_state"
        >
          <b-form-input type="password" id="password" :state="password_state" v-model="password" trim/>
        </b-form-group>
      </form>
    </b-modal>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        username: '',
        firstname: '',
        lastname: '',
        password: ''
      }
    },
    computed: {
      username_state () {
        return this.username.length >= 4 ? true : false
      },
      firstname_state () {
        return this.firstname.length >= 1 ? true : false
      },
      lastname_state () {
        return this.lastname.length >= 1 ? true : false
      },
      password_state () {
        return this.password.length >= 8 ? true : false
      }
    },
    methods: {
      clearForm () {
        this.username  = '',
        this.firstname = '',
        this.lastname  = '',
        this.password  = ''
      },
      showModal () {
        this.clearForm();
        this.$refs.modal.show()
      },
      handleOk (event) {
        event.preventDefault()

        var params = {
          username: this.username,
          firstname: this.firstname,
          lastname: this.lastname,
          password: this.password
        }

        this.$http.post('/admin/users.json', { user: params }).then(response => {
          this.clearForm();

          this.$refs.modal.hide();
          // debugger
          // console.log(response)
          // // get body data
          // this.someData = response.body;

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

</style>

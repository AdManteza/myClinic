<template>
  <div>
    <b-btn @click="showModal" variant="primary">Add a new user</b-btn>
    <!-- Modal Component -->
    <b-modal id="userForm"
             ref="modal"
             title="New User"
             @cancel="clearForm"
             @ok="handleOk">
      <b-form>
        <b-form-group horizontal
                      label="Username"
                      label-for="username">
          <b-form-input id="username"
                        v-model.trim="user.username"
                        :state="!$v.user.username.$invalid"/>
        </b-form-group>

        <b-form-group horizontal
                      label="First Name"
                      label-for="firstname">
          <b-form-input id="firstname"
                        v-model.trim="user.firstname"
                        :state="!$v.user.firstname.$invalid"/>
        </b-form-group>

        <b-form-group horizontal
                      label="Last Name"
                      label-for="lastname">
          <b-form-input id="lastname"
                        v-model.trim="user.lastname"
                        :state="!$v.user.lastname.$invalid"/>
        </b-form-group>

        <b-form-group horizontal
                      label="Password"
                      label-for="password">
          <b-form-input type="password"
                        id="password"
                        v-model.trim="user.password"
                        :state="!$v.user.password.$invalid"/>
        </b-form-group>
      </b-form>
    </b-modal>
  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, minLength } from 'vuelidate/lib/validators'

  export default {
    data() {
      return {
        user: {}
      }
    },
    mixins: [validationMixin],
    validations: {
      user: {
        username: {
          required,
          minLength: minLength(4)
        },
        firstname: {
          required,
          minLength: minLength(1)
        },
        lastname: {
          required,
          minLength: minLength(1)
        },
        password: {
          required,
          minLength: minLength(8)
        }
      }
    },
    methods: {
      clearForm () {
        this.user = {}
      },
      showModal () {
        this.clearForm();
        this.$refs.modal.show()
      },
      handleOk (event) {
        event.preventDefault()

        var params = {
          username: this.user.username,
          firstname: this.user.firstname,
          lastname: this.user.lastname,
          password: this.user.password
        }

        this.$http.post('/admin/users.json', { user: params })
          .then(
            response => {
              this.clearForm();
              this.$refs.modal.hide();
            },
            response => {
              // error callback
              console.log(response)
            }
          );
      }
    }
  }
</script>

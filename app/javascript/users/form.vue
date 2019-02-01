<template>
  <div>
    <b-btn @click="showModal" variant="primary">Add a new user</b-btn>
    <!-- Modal Component -->
    <b-modal id="userForm"
             ref="modal"
             title="New User"
             ok-title="Add"
             v-bind:ok-disabled="$v.user.$invalid"
             @cancel="clearForm"
             @ok="handleOk">
      <b-alert show dismissible variant="danger" v-if="saveError">
        <p>There was a problem saving the User. Please try again. If problem persists, please contact Technical Support.</p>
      </b-alert>
      <b-form>
        <b-form-group horizontal
                      label="Username"
                      label-for="username">
          <b-form-input id="username"
                        v-model.trim="user.username"
                        :state="!$v.user.username.$invalid"
                        aria-describedby="usernameLiveFeedback"/>
          <b-form-invalid-feedback id="usernameLiveFeedback">
            This is a required field and must be at least 4 characters
          </b-form-invalid-feedback>
        </b-form-group>

        <b-form-group horizontal
                      label="First Name"
                      label-for="firstname">
          <b-form-input id="firstname"
                        v-model.trim="user.firstname"
                        :state="!$v.user.firstname.$invalid"
                        aria-describedby="firstnameLiveFeedback"/>
          <b-form-invalid-feedback id="firstnameLiveFeedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>

        <b-form-group horizontal
                      label="Last Name"
                      label-for="lastname">
          <b-form-input id="lastname"
                        v-model.trim="user.lastname"
                        :state="!$v.user.lastname.$invalid"
                        aria-describedby="lastnameLiveFeedback"/>
          <b-form-invalid-feedback id="lastnameLiveFeedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>

        <b-form-group horizontal
                      label="Password"
                      label-for="password">
          <b-form-input type="password"
                        id="password"
                        v-model.trim="user.password"
                        :state="!$v.user.password.$invalid"
                        aria-describedby="passwordLiveFeedback"/>
          <b-form-invalid-feedback id="passwordLiveFeedback">
            Password required
          </b-form-invalid-feedback>
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
        user: {},
        saveError: false
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
        this.saveError = false

        const params = {
          username: this.user.username,
          firstname: this.user.firstname,
          lastname: this.user.lastname,
          password: this.user.password
        }

        let promise = this.$http.post('/admin/users.json', { user: params })

        return promise.then((data) => {
          this.clearForm()
          this.$refs.modal.hide()

          // ToDo.. Add the newly created user to the table
        }).catch(error => {
          this.saveError = true
        })
      }
    }
  }
</script>

<template>
  <div>
    <b-btn @click="showModal" size="sm" variant="outline-warning">{{ currentUser ? "Logout " + currentUser : 'Admin Login' }}</b-btn>

    <!-- Modal Component -->
    <b-modal id="loginForm"
             ref="modal"
             title="Login"
             ok-title="Login"
             @cancel="clearForm"
             @ok="handleOk">
      <b-alert show dismissible variant="danger" v-if="loginError">
        <p>Sorry. Invalid Password or Username</p>
      </b-alert>
      <b-form>
        <b-form-group horizontal
                      label="Username"
                      label-for="username">
          <b-form-input id="admin-username"
                        v-model.trim="admin_user.username"
                        :state="!$v.admin_user.username.$invalid"
                        aria-describedby="usernameLiveFeedback"/>
          <b-form-invalid-feedback id="usernameLiveFeedback">
            Username required
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Password"
                      label-for="password">
          <b-form-input type="password"
                        id="admin-password"
                        v-model.trim="admin_user.password"
                        :state="!$v.admin_user.password.$invalid"
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
    data () {
      return {
        admin_user: {},
        loginError: false
      }
    },
    props: ['currentUser'],
    mixins: [ validationMixin ],
    validations: {
      admin_user: {
        username: {
          required
        },
        password: {
          required
        }
      }
    },
    methods: {
      clearForm () {
        this.admin_user = {}
      },
      showModal () {
        this.clearForm();

        if (this.currentUser) {
          let promise = this.$http.get('/admin_logout.json')

          return promise.then((data) => {
            window.location.href = data.body.location
          })

        } else {
          this.$refs.modal.show()
        }
      },
      handleOk (event) {
        event.preventDefault()
        this.loginError = false

        const params = {
          username: this.admin_user.username,
          password: this.admin_user.password
        }

        let promise = this.$http.post('/admin_login.json', { admin_user_session: params })

        return promise.then((data) => {
          window.location.href = data.body.location
        }).catch(error => {
          this.loginError = true
        })
      }
    }
  }
</script>

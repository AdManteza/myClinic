<template>
  <div>
    <b-btn @click="showModal" size="sm" variant="outline-warning">{{ login_status }}</b-btn>

    <!-- Modal Component -->
    <b-modal id="loginForm"
             ref="modal"
             title="Login"
             ok-title="Login"
             @cancel="clearForm"
             @ok="handleOk">
      <b-alert show dismissible variant="danger" v-if="loginError">
        <p>There was a problem saving the User. Please try again. If problem persists, please contact Technical Support.</p>
      </b-alert>
      <b-form>
        <b-form-group horizontal
                      label="Username"
                      label-for="username">
          <b-form-input id="username"
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
                        id="password"
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
        login_status: 'Admin Login',
        loginError: false
      }
    },
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
        this.$refs.modal.show()
      },
      handleOk (event) {
        event.preventDefault()
        this.loginError = false

        const params = {
          username: this.admin_user.username,
          password: this.admin_user.password
        }

        let promise = this.$http.post('/admin/sessions.json', { admin_user_session: params })

        return promise.then((data) => {
          this.login_status = 'Admin Logout'
          window.location.href = data.body.location
        }).catch(error => {
          this.loginError = true
        })
      }
    }
  }
</script>

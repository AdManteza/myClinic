<template>
  <b-modal id="userForm"
           v-bind:title="title"
           ok-title="Save"
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
                    label="Contact#"
                    label-for="contact_number">
        <b-form-input type="tel"
                      id="contact_number"
                      v-model.trim="user.contact_number"
                      placeholder="Optional"/>
      </b-form-group>

      <b-form-group horizontal
                    label="Email"
                    label-for="email_address">
        <b-form-input type="email"
                      id="email_address"
                      v-model.trim="user.email_address"
                      placeholder="Optional"/>
      </b-form-group>

      <b-form-group horizontal
                    label="Password"
                    label-for="password">
        <b-form-input type="password"
                      id="password"
                      v-model.trim="user.password"
                      placeholder="This is only optional for Administrators"/>
      </b-form-group>
    </b-form>
  </b-modal>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, minLength } from 'vuelidate/lib/validators'

  export default {
    data () {
      return {
        user: {},
        saveError: false,
        editMode: false
      }
    },
    computed: {
      title () {
        return (this.editMode ? 'Edit User' : 'Add User')
      }
    },
    created () {
      this.$eventHub.$on('edit-a-user', user => {
        this.user = user
        this.editMode = true
      })
    },
    beforeDestroy () {
      this.$eventHub.$off('edit-a-user')
    },
    mixins: [ validationMixin ],
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
        }
      }
    },
    methods: {
      clearForm () {
        this.user = {}
      },
      closeForm () {
        this.clearForm()
        this.$root.$emit('bv::hide::modal', 'userForm')
      },
      handleCreateUser (params) {
        let promise = this.$http.post('/admin/users.json', { user: params })

        return promise.then((data) => {
          this.closeForm()
          this.$eventHub.$emit('new-user-added', data.body)
        }).catch(error => {
          this.saveError = true
        })
      },
      handleUpdateUser (params) {
        let promise = this.$http.put(`/admin/users/${this.user.id}.json`, { user: params })

        return promise.then((data) => {
          this.closeForm()
          this.editMode = false
        }).catch(error => {
          this.saveError = true
        })
      },
      handleOk (event) {
        event.preventDefault()
        this.saveError = false

        const params = {
          username: this.user.username,
          firstname: this.user.firstname,
          lastname: this.user.lastname,
          password: this.user.password,
          contact_number: this.user.contact_number,
          email_address: this.user.email_address,
        }

        if (this.editMode) {
          this.handleUpdateUser(params)
        } else {
          this.handleCreateUser(params)
        }
      }
    }
  }
</script>

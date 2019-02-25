<template>
  <div>
    <b-alert show dismissible variant="danger" v-if="deleteError">
      <p>There was a problem deleting the User. Please try again. If problem persists, please contact Technical Support.</p>
    </b-alert>
    <b-alert :show="showSucessMessage"
              dismissible
              fade
              variant="success"
              @dismissed="showSucessMessage=0">
      <p>{{successMessage}}</p>
    </b-alert>
    <b-table id="users-table"
             show-empty
             striped
             responsive
             no-provider-paging
             no-provider-sorting
             hover
             :sort-by.sync="sortBy"
             :sort-desc.sync="sortDesc"
             :busy.sync="isBusy"
             :fields="fields"
             :items="users"
             :current-page="currentPage"
             :per-page="perPage">
      <template slot="actions" slot-scope="row" >
        <b-button size="sm" variant="link" @click.stop="editUser(row.item)">
          Edit
        </b-button>
        <b-button size="sm" variant="link" @click.stop="bookAppointmentForUser(row.item)">
          Book
        </b-button>
        <b-button size="sm" variant="link" @click.stop="removeUser(row.item, row.index)">
          Remove?
        </b-button>
      </template>
    </b-table>
    <b-row>
      <b-col md="6">
        <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage"/>
      </b-col>
    </b-row>
    <b-btn v-b-modal.userForm variant="primary">New Patient</b-btn>

    <AppointmentForm></AppointmentForm>
    <UserForm></UserForm>
  </div>
</template>

<script>
  import UserForm from '../users/form.vue'
  import AppointmentForm from '../appointments/form.vue'
  
  export default {
    data () {
      return {
        users: [],
        sortBy: 'id',
        sortDesc: true,
        fields: [
          { key: 'id', label: 'ID', sortable: true },
          { key: 'username', label: 'Username', sortable: true },
          { key: 'firstname', label: 'First Name', sortable: true },
          { key: 'lastname', label: 'Last Name', sortable: true },
          { key: 'contact_number', label: 'Contact Number', sortable: true },
          { key: 'email_address', label: 'Email', sortable: true },
          { key: 'actions', label: 'Actions', sortable: false }
        ],
        currentPage: 1,
        totalRows: 0,
        perPage: 10,
        pageOptions: [ 5, 10, 15 ],
        deleteError: false,
        showSucessMessage: 0,
        successMessage: '',
        isBusy: false
      }
    },
    components: {
      UserForm, AppointmentForm
    },
    mounted () {
      this.getUsers()
    },
    created () {
      this.$eventHub.$on('new-user-added', user => {
        this.addUserToTable(user)
      })

      this.$eventHub.$on('user-updated', user => {
        this.successMessage = `Successfully updated ${user.full_name}`
        this.showSucessMessage = 5 //in seconds
      })

      this.$eventHub.$on('new-appointment', appointment => {
        this.successMessage = `Successfully booked ${appointment.patient_name} on ${appointment.date_and_time}`
        this.showSucessMessage = 10 //in seconds
      })
    },
    beforeDestroy () {
      this.$eventHub.$off('new-user-added')
      this.$eventHub.$off('user-updated')
      this.$eventHub.$off('new-appointment')
    },
    methods: {
      editUser (user) {
        this.$eventHub.$emit('edit-a-user', user)
        this.$root.$emit('bv::show::modal', 'userForm')
      },
      bookAppointmentForUser (user) {
        this.$eventHub.$emit('book-appointment-for-user', user)
        this.$root.$emit('bv::show::modal', 'appointmentForm')
      },
      getUsers () {
        let promise = this.$http.get('/admin/users.json')

        return promise.then((data) => {
          const items    = data.body
          this.totalRows = items.length
          this.users     = items
          this.isBusy    = false
        }).catch(error => {
          this.isBusy = false

          return []
        })
      },
      removeUser (user, userIndex) {
        this.deleteError = false
        this.userIndex   = userIndex
        var dontDelete   = !(confirm(`Really delete ${user.full_name}?`))

        if (dontDelete) {
          return;
        }

        let promise = this.$http.delete(`/admin/users/${user.id}.json`)

        return promise.then((data) => {
          this.successMessage = 'Successfully removed user!'
          this.showSucessMessage = 5 //in seconds
          this.$delete(this.users, this.userIndex)
        }).catch(error => {
          this.deleteError = true
        })
      },
      addUserToTable (user) {
        this.successMessage = `Successfully added ${user.full_name}`
        this.showSucessMessage = 5 //in seconds
        this.users.push(user)
      }
    }
  }
</script>
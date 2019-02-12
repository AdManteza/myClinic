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
      <p>Successfully removed user!</p>
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
        <b-button size="sm" variant="secondary" @click.stop="editUser(row.item)" class="mr-1">
          Edit
        </b-button>
        <b-button size="sm" variant="success" @click.stop="createAppointment(row.item)" class="mr-1">
          Book an Appointment
        </b-button>
        <b-button size="sm" variant="danger" @click.stop="removeUser(row.item, row.index, $event.target)">
          Remove?
        </b-button>
      </template>
    </b-table>
    <b-row>
      <b-col md="6">
        <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage"/>
      </b-col>
    </b-row>
    <b-btn @click="addUser()" variant="primary">Add a new user</b-btn>

    <UserForm :user-to-edit="userToEdit"></UserForm>
  </div>
</template>

<script>
  import UserForm from '../users/form.vue'

  export default {
    data () {
      return {
        users: this.getUsers,
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
        userToEdit: {},
        isBusy: false
      }
    },
    components: {
      UserForm
    },
    created () {
      this.$eventHub.$on('new-user-added', this.refreshTable(this.user))
    },
    beforeDestroy () {
      this.$eventHub.$off('new-user-added');
    },
    methods: {
      createAppointment (user) {
        console.log(user.username)
      },
      addUser () {
        this.userToEdit = {}
        this.$root.$emit('bv::show::modal', 'userForm')
      },
      editUser (user) {
        this.userToEdit = user
        this.$root.$emit('bv::show::modal', 'userForm')
      },
      getUsers () {
        let promise = this.$http.get('/admin/users.json')

        return promise.then((data) => {
          const items    = data.body
          this.totalRows = items.length
          this.isBusy    = false

          return(items)
        }).catch(error => {
          this.isBusy = false

          return []
        })
      },
      removeUser (user, row_index, event_target) {
        this.deleteError = false
        var dontDelete   = !(confirm(`Really delete ${user.firstname} ${user.lastname}?`))

        if (dontDelete) {
          return;
        }

        let promise = this.$http.delete(`/admin/users/${user.id}.json`)

        return promise.then((data) => {
          this.showSucessMessage = 5 //in seconds
          this.refreshTable()
        }).catch(error => {
          this.deleteError = true
        })
      },
      refreshTable (user) {
        debugger
        this.$root.$emit('bv::refresh::table', 'users-table')
      }
    }
  }
</script>

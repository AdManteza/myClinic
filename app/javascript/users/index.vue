<template>
  <div>
    <b-table id="users-table"
             show-empty
             striped
             bordered
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
      <template slot="actions" slot-scope="row">
        <b-button size="sm" variant="secondary">
          User Info
        </b-button>
        <b-button size="sm" variant="danger" >
          Remove?
        </b-button>
      </template>
    </b-table>
    <b-row>
      <b-col md="6">
        <b-pagination :total-rows="totalRows" :per-page="perPage" v-model="currentPage"/>
      </b-col>
    </b-row>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        users: this.getUsers,
        sortBy: 'id',
        sortDesc: true,
        fields: [
          { key: 'id', label: 'User ID', sortable: true },
          { key: 'username', label: 'Username', sortable: true },
          { key: 'firstname', label: 'First Name', sortable: true },
          { key: 'lastname', label: 'Last Name', sortable: true },
          { key: 'actions', label: 'Actions', sortable: false }
        ],
        currentPage: 1,
        totalRows: 0,
        perPage: 10,
        pageOptions: [ 5, 10, 15 ],
        isBusy: false
      }
    },
    created () {
      this.$eventHub.$on('new-user-added', this.refreshTable)
    },
    beforeDestroy () {
      this.$eventHub.$off('new-user-added');
    },
    methods: {
      getUsers () {
        let promise = this.$http.get('/admin/users.json')

        return promise.then((data) => {
          const items = data.body
          this.totalRows = items.length
          this.isBusy = false

          return(items)
        }).catch(error => {
          this.isBusy = false

          return []
        })
      },
      refreshTable () {
        this.$root.$emit('bv::refresh::table', 'users-table')
      }
    }
  }
</script>

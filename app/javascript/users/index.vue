<template>
  <div>
    <b-table id="users-table"
             show-empty
             striped
             responsive
             no-provider-paging
             :busy.sync="isBusy"
             :fields="fields"
             :items="users"
             :current-page="currentPage"
             :per-page="perPage">
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
        fields: [
          { key: 'id', label: 'User ID' },
          { key: 'username', label: 'Username' },
          { key: 'firstname', label: 'First Name' },
          { key: 'lastname', label: 'Last Name' }
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

<template>
  <b-table striped hover :busy.sync="isBusy" :fields="fields" :items="getUsers"></b-table>
</template>

<script>
  export default {
    data () {
      return {
        fields: [
          { key: 'id', label: 'User ID' },
          { key: 'username', label: 'Username' },
          { key: 'firstname', label: 'First Name' },
          { key: 'lastname', label: 'Last Name' }
        ],
        isBusy: false
      }
    },
    methods: {
      getUsers (ctx) {
        let promise = this.$http.get('/admin/users.json')

        return promise.then((data) => {
          const items = data.body
          this.isBusy = false

          return(items)
        }).catch(error => {
          this.isBusy = false

          return []
        })
      }
    }
  }
</script>

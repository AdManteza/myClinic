<template>
  <b-form-radio :value="session"
                v-model="selected"
                name="option"
                @change="setSelected()"
                class="rounded shadow">
    {{session.start_time}} to {{session.end_time}}
  </b-form-radio>
</template>
<script>
  export default {
    props: ['session'],
    data () {
      return {
        selected: ''
      }
    },
    methods: {
      setSelected () {
        this.$eventHub.$emit('set-selected-session', this.session)
      }
    }
  }
</script>

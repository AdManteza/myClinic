<script>
  import Calendar from 'components/shared/calendar.vue'

  export default {
    // register component to be usable in views
    components: {
      calendar: Calendar
    },
    // props are all the properties that will be passed to this component
    // we will see how easy it is for us to pass the devise error message to vue
    // without having to reinvent everything and falling back to ajax calls
    props: {
      errors: Array
    },
    // data are the actual state which are changed in real time
    // we don't use them much, this is how it can be done
    data: function() {
      return ({
        user: {
          name: '',
          email: '',
          password: ''
        },
        // these are the validation rules that I'll pass to my component
        // if you have used react, validation is very easy in vue
        rules: {
          email: [
            {type: 'email', trigger: 'blur,change'}
          ]
        }
      });
    }
  }
</script>

<template>
  <div>
    <h1>Hello</h1>
    <calendar></calendar>
    <el-row>
      <el-button>Default</el-button>
      <el-button type="primary">Primary</el-button>
      <el-button type="success">Success</el-button>
      <el-button type="info">Info</el-button>
      <el-button type="warning">Warning</el-button>
      <el-button type="danger">Danger</el-button>
    </el-row>
  </div>
</template>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

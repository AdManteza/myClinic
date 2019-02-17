<template>
  <div class="rounded shadow">
    <table class="w-100 mt-3 table table-borderless">
      <thead>
        <tr>
          <th scope="col">Start Time</th>
          <th scope="col">End Time</th>
          <th scope="col"></th>
        </tr>
      </thead>
      <tbody >
        <tr scope="row">
          <td>{{session.start_time}}</td>
          <td>{{session.end_time}}</td>
          <td>
            <b-form-radio v-model="selected" name="session.id">Select</b-form-radio>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>
<script>
  export default {
    props: ['session']
  }
</script>

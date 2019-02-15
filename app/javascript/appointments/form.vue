<template>
  <div>
    <b-btn @click="createAppointments()" variant="primary">Create Appointments</b-btn>
    <b-modal id="appointmentForm"
             title="Bulk Create Appointments"
             size="lg"
             ok-title="Save">
      <b-form>
        <b-form-group horizontal
                      label="From:"
                      label-for="appointment-start-date">
          <b-form-input id="appointment-start-date" type="date"/>
        </b-form-group>
        <b-form-group horizontal
                      label="To:"
                      label-for="appointment-end-date">
          <b-form-input id="appointment-end-date" type="date"/>
        </b-form-group>
        <b-form-group horizontal
                      label="Starting time"
                      label-for="appointment-starting-time"
                      description="First appointment will start at this time">
          <b-form-input id="appointment-duration" type="time"/>
        </b-form-group>
        <b-form-group horizontal
                      label="Duration"
                      label-for="appointment-duration">
          <b-form-input id="appointment-duration" type="number" placeholder="Duration of each appointment(in minutes)"/>
        </b-form-group>
        <b-form-group horizontal
                      label="Interval"
                      label-for="appointment-interval">
          <b-form-input id="appointment-duration" type="number" placeholder="Interval between appointments(in minutes)"/>
        </b-form-group>
        <b-form-group horizontal
                      label="Appointments per day"
                      label-for="appointments-per-day">
          <b-form-input id="appointments-per-day" type="number"/>
        </b-form-group>
      </b-form>
    </b-modal>
  </div>
</template>
<script>
  export default {
    methods: {
      createAppointments () {
        this.$root.$emit('bv::show::modal', 'appointmentForm')
      }
    }
  }
</script>

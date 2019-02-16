<template>
  <div>
    <b-btn @click="createAppointments()" variant="primary">Create Appointments</b-btn>
    <b-modal id="appointmentForm"
             title="Bulk Create Appointments"
             ok-title="Save">
      <b-form>
        <b-form-group horizontal
                      label="From:"
                      label-for="appointment-start-date">
          <b-form-input id="appointment-start-date"
                        type="date"
                        :state="!$v.appointment.startDate.$invalid"
                        v-model.trim="appointment.startDate"
                        aria-describedby="startDateFeedback"/>
          <b-form-invalid-feedback id="startDateFeedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="To:"
                      label-for="appointment-end-date">
          <b-form-input id="appointment-end-date"
                        type="date"
                        :state="!$v.appointment.endDate.$invalid"
                        v-model.trim="appointment.endDate"
                        aria-describedby="endDateFeedback"/>
          <b-form-invalid-feedback id="endDateFeedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Starting time"
                      label-for="appointment-starting-time"
                      description="First appointment will start at this time">
          <b-form-input id="appointment-starting-time"
                        type="time"
                        :state="!$v.appointment.startingTime.$invalid"
                        v-model.trim="appointment.startingTime"
                        aria-describedby="startingTimeFeedback"/>
          <b-form-invalid-feedback id="startingTimeFeedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Duration"
                      label-for="appointment-duration">
          <b-form-input id="appointment-duration"
                        type="number"
                        placeholder="Duration of each appointment(in minutes)"
                        :state="!$v.appointment.duration.$invalid"
                        v-model.trim="appointment.duration"
                        aria-describedby="durationFeedback"/>
          <b-form-invalid-feedback id="durationFeedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Interval"
                      label-for="appointment-interval">
          <b-form-input id="appointment-interval"
                        type="number"
                        placeholder="Interval between appointments(in minutes)"
                        :state="!$v.appointment.interval.$invalid"
                        v-model.trim="appointment.interval"
                        aria-describedby="intervalFeedback"/>
          <b-form-invalid-feedback id="intervalFeedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Per day"
                      label-for="appointments-per-day">
          <b-form-input id="appointments-per-day"
                        type="number"
                        placeholder="Number of appointments for day"
                        :state="!$v.appointment.perDay.$invalid"
                        v-model.trim="appointment.perDay"
                        aria-describedby="perDayFeedback"/>
          <b-form-invalid-feedback id="perDayFeedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
      </b-form>
    </b-modal>
  </div>
</template>
<script>
  import { validationMixin } from 'vuelidate'
  import { required } from 'vuelidate/lib/validators'

  export default {
    data () {
      return {
        appointment: {},
        saveError: false
      }
    },
    mixins: [ validationMixin ],
    validations: {
      appointment: {
        startDate: {
          required
        },
        endDate: {
          required
        },
        startingTime: {
          required
        },
        duration: {
          required
        },
        interval: {
          required
        },
        perDay: {
          required
        }
      }
    },
    methods: {
      createAppointments () {
        this.$root.$emit('bv::show::modal', 'appointmentForm')

        let promise = this.$http.post('/admin/appointments.json', { appointment: appointment })
      }
    }
  }
</script>

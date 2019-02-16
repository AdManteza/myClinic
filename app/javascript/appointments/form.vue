<template>
  <div>
    <b-btn @click="showAppointmentForm()" variant="primary">Bulk Create Appointments</b-btn>
    <b-modal id="appointmentForm"
             title="Bulk Create Appointments"
             ok-title="Bulk Create"
             v-bind:ok-disabled="$v.appointment.$invalid"
             @cancel="closeAppointmentForm"
             @ok="handleOk">
      <b-alert show dismissible variant="danger" v-if="saveError">
        <p>There was a problem bulk creating the appointments. Please try again. If problem persists, please contact Technical Support.</p>
      </b-alert>
      <b-form>
        <b-form-group horizontal
                      label="From:"
                      label-for="appointment-start-date">
          <b-form-input id="appointment-start-date"
                        type="date"
                        :state="!$v.appointment.start_date.$invalid"
                        v-model.trim="appointment.start_date"
                        aria-describedby="start_date_feedback"/>
          <b-form-invalid-feedback id="start_date_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="To:"
                      label-for="appointment-end-date">
          <b-form-input id="appointment-end-date"
                        type="date"
                        :state="!$v.appointment.end_date.$invalid"
                        v-model.trim="appointment.end_date"
                        aria-describedby="end_date_feedback"/>
          <b-form-invalid-feedback id="end_date_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Starting time"
                      label-for="appointment-starting-time"
                      description="First appointment will start at this time">
          <b-form-input id="appointment-starting-time"
                        type="time"
                        :state="!$v.appointment.starting_time.$invalid"
                        v-model.trim="appointment.starting_time"
                        aria-describedby="starting_time_feedback"/>
          <b-form-invalid-feedback id="starting_time_feedback">
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
                        aria-describedby="duration_feedback"/>
          <b-form-invalid-feedback id="duration_feedback">
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
                        aria-describedby="interval_feedback"/>
          <b-form-invalid-feedback id="interval_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Per day"
                      label-for="appointments-per-day">
          <b-form-input id="appointments-per-day"
                        type="number"
                        placeholder="Number of appointments for day"
                        :state="!$v.appointment.per_day.$invalid"
                        v-model.trim="appointment.per_day"
                        aria-describedby="per_day_feedback"/>
          <b-form-invalid-feedback id="per_day_feedback">
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
        start_date: {
          required
        },
        end_date: {
          required
        },
        starting_time: {
          required
        },
        duration: {
          required
        },
        interval: {
          required
        },
        per_day: {
          required
        }
      }
    },
    methods: {
      showAppointmentForm () {
        this.$root.$emit('bv::show::modal', 'appointmentForm')
      },
      closeAppointmentForm () {
        this.appointment = {}
        this.$root.$emit('bv::hide::modal', 'appointmentForm')
      },
      handleOk (event) {
        event.preventDefault()
        this.saveError = false

        let appointmentParams = Object.assign(this.appointment, { bulk_create: true })

        let promise = this.$http.post('/admin/appointments.json', { appointment: appointmentParams })

        return promise.then((data) => {
          debugger
          this.closeAppointmentForm()
          this.saveError = false
        }).catch(error => {
          debugger
          this.saveError = true
        })
      }
    }
  }
</script>

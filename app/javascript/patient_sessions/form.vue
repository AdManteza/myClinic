<template>
  <div>
    <b-btn @click="showPatientSessionForm()" variant="primary">Bulk Create Patient Sessions</b-btn>
    <b-modal id="patientSessionForm"
             title="Bulk Create Patient Sessions"
             ok-title="Bulk Create"
             v-bind:ok-disabled="$v.patient_session.$invalid"
             @cancel="closePatientSessionForm"
             @ok="handleOk">
      <b-alert show dismissible variant="danger" v-if="saveError">
        <p>There was a problem bulk creating the patient sessions. Please try again. If problem persists, please contact Technical Support.</p>
      </b-alert>
      <b-form>
        <b-form-group horizontal
                      label="From:"
                      label-for="patient_session-start-date">
          <b-form-input id="patient_session-start-date"
                        type="date"
                        :state="!$v.patient_session.start_date.$invalid"
                        v-model.trim="patient_session.start_date"
                        aria-describedby="start_date_feedback"/>
          <b-form-invalid-feedback id="start_date_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="To:"
                      label-for="patient_session-end-date">
          <b-form-input id="patient_session-end-date"
                        type="date"
                        :state="!$v.patient_session.end_date.$invalid"
                        v-model.trim="patient_session.end_date"
                        aria-describedby="end_date_feedback"/>
          <b-form-invalid-feedback id="end_date_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Starting time"
                      label-for="patient_session-starting-time"
                      description="The first Patient Session will start at this time">
          <b-form-input id="patient_session-starting-time"
                        type="time"
                        :state="!$v.patient_session.starting_time.$invalid"
                        v-model.trim="patient_session.starting_time"
                        aria-describedby="starting_time_feedback"/>
          <b-form-invalid-feedback id="starting_time_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Duration"
                      label-for="patient_session-duration">
          <b-form-input id="patient_session-duration"
                        type="number"
                        placeholder="Duration of each Patient Session(in minutes)"
                        :state="!$v.patient_session.duration.$invalid"
                        v-model.trim="patient_session.duration"
                        aria-describedby="duration_feedback"/>
          <b-form-invalid-feedback id="duration_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Interval"
                      label-for="patient_session-interval">
          <b-form-input id="patient_session-interval"
                        type="number"
                        placeholder="Interval between Patient Sessions(in minutes)"
                        :state="!$v.patient_session.interval.$invalid"
                        v-model.trim="patient_session.interval"
                        aria-describedby="interval_feedback"/>
          <b-form-invalid-feedback id="interval_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group horizontal
                      label="Per day"
                      label-for="patient_sessions-per-day">
          <b-form-input id="patient_sessions-per-day"
                        type="number"
                        placeholder="Number of Patient Sessions per day"
                        :state="!$v.patient_session.per_day.$invalid"
                        v-model.trim="patient_session.per_day"
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
        patient_session: {},
        saveError: false
      }
    },
    mixins: [ validationMixin ],
    validations: {
      patient_session: {
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
      showPatientSessionForm () {
        this.$root.$emit('bv::show::modal', 'patientSessionForm')
      },
      closePatientSessionForm () {
        this.patient_session = {}
        this.$root.$emit('bv::hide::modal', 'patientSessionForm')
      },
      handleOk (event) {
        event.preventDefault()
        this.saveError = false

        let patientSessionParams = Object.assign(this.patient_session, { bulk_create: true })

        let promise = this.$http.post('/admin/appointments.json', { patient_session: patientSessionParams })

        return promise.then((data) => {
          this.closePatientSessionForm()
          this.saveError = false
        }).catch(error => {
          this.saveError = true
        })
      }
    }
  }
</script>

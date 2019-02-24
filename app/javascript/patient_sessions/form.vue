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
        <b-form-group :label="label_duration"
                      label-for="patient_session-duration">
          <b-form-input id="patient_session-duration"
                        type="range"
                        min="5"
                        step="5"
                        max="60"
                        :state="!$v.patient_session.duration.$invalid"
                        v-model.trim="patient_session.duration"
                        aria-describedby="duration_feedback"/>
          <b-form-invalid-feedback id="duration_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group :label="label_interval"
                      label-for="patient_session-interval">
          <b-form-input id="patient_session-interval"
                        type="range"
                        min="0"
                        step="5"
                        max="60"
                        :state="!$v.patient_session.interval.$invalid"
                        v-model.trim="patient_session.interval"
                        aria-describedby="interval_feedback"/>
          <b-form-invalid-feedback id="interval_feedback">
            This is a required field
          </b-form-invalid-feedback>
        </b-form-group>
        <b-form-group :label="label_sessions_per_day"
                      label-for="patient_sessions-per-day">
          <b-form-input id="patient_sessions-per-day"
                        type="range"
                        min="1"
                        max="12"
                        size="sm"
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
        patient_session: {
          duration: '5',
          interval: '0',
          per_day: '1'
        },
        saveError: false
      }
    },
    computed: {
      label_duration () {
        return `Duration of each Patient Session: ${this.patient_session.duration} minutes`
      },
      label_interval () {
        return `Interval between Patient Sessions: ${this.patient_session.interval} minutes`
      },
      label_sessions_per_day () {
        return `${this.patient_session.per_day} sessions per day`
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

        let patientSessionParams = {
          start_date: this.patient_session.start_date,
          end_date: this.patient_session.end_date,
          starting_time: this.patient_session.starting_time,
          duration: this.patient_session.duration,
          interval: this.patient_session.interval,
          per_day: this.patient_session.per_day
        }

        let promise = this.$http.post('/admin/patient_sessions.json', { patient_session: patientSessionParams })

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

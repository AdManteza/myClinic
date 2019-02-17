<template>
  <div>
    <b-modal id="appointmentForm"
             title="Book an Appointment"
             ok-title="Save"
             v-bind:ok-disabled="$v.appointment.$invalid"
             size="xl"
             @cancel="closeAppointmentForm"
             @ok="handleOk">
      <b-alert show dismissible variant="danger" v-if="saveError">
        <p>There was a problem booking your appointment. Please try again. If problem persists, please contact Technical Support.</p>
      </b-alert>
      <b-form>
        <b-input-group size="sm"
                       class="w-25">
          <b-form-input type="date" v-model.trim="searchDate"/>
          <b-input-group-append>
            <b-button @click="searchForAvailablePatientSessions()" text="Search" variant="success">Search</b-button>
          </b-input-group-append>
        </b-input-group>
      </b-form>
    </b-modal>
  </div>
</template>
<script>
  import { validationMixin } from 'vuelidate'
  import { required } from 'vuelidate/lib/validators'
  import VueCal from 'vue-cal'

  export default {
    data () {
      return {
        appointment: {},
        searchDate: '',
        availableSessions: [],
        nothingAvailable: false,
        saveError: false,
        searchError: false
      }
    },
    mixins: [ validationMixin ],
    components: {
      VueCal
    },
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
      closeAppointmentForm () {
        this.appointment = {}
        this.$root.$emit('bv::hide::modal', 'appointmentForm')
      },
      searchForAvailablePatientSessions () {
        this.nothingAvailable = false
        this.searchError = false

        let searchParams = {
          search_date: this.searchDate,
          available_only: true
        }

        let promise = this.$http.get('/admin/patient_sessions.json', { params: searchParams })

        return promise.then((data) => {
          this.availableSessions = data
        }).catch(error => {
          this.searchError = true
        })
      },
      handleOk (event) {
        event.preventDefault()
        this.saveError = false

        let appointmentParams = Object.assign(this.appointment, { bulk_create: true })

        let promise = this.$http.post('/admin/appointments.json', { appointment: appointmentParams })

        return promise.then((data) => {
          this.closeAppointmentForm()
          this.saveError = false
        }).catch(error => {
          this.saveError = true
        })
      }
    }
  }
</script>

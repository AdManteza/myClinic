<template>
  <div>
    <b-modal scrollable
             id="appointmentForm"
             title="Book an Appointment"
             ok-title="Save"
             :ok-disabled="$v.selected_session.$invalid"
             @cancel="closeAppointmentForm"
             @ok="handleOk">
      <b-alert show dismissible variant="danger" v-if="saveError">
        <p>There was a problem booking your appointment. Please try again. If problem persists, please contact Technical Support.</p>
      </b-alert>
      <b-form>
        <b-input-group class="w-75">
          <b-form-input type="date" v-model.trim="searchDate" @change="searchForAvailablePatientSessions()"/>
          <b-input-group-append>
            <b-button @click="searchForAvailablePatientSessions()" size="sm" text="Search" variant="success">Search for Sessions</b-button>
          </b-input-group-append>
        </b-input-group>
      </b-form>
      <b-alert show dismissible variant="warning" class="mt-4" v-if="nothingAvailable">
        <p>Unfortunately there are no available sessions based on your selected date. Please try again</p>
      </b-alert>
      <div horizontal="md" class="mt-4">
        <AvailablePatientSession :session="session" v-for="session in availablePatientSessions" :key="session.id"></AvailablePatientSession>
      </div>
    </b-modal>
  </div>
</template>
<script>
  import { validationMixin } from 'vuelidate'
  import { required } from 'vuelidate/lib/validators'
  import AvailablePatientSession from '../patient_sessions/available.vue'

  export default {
    data () {
      return {
        user: {},
        selected_session: {},
        searchDate: '',
        availablePatientSessions: [],
        saveError: false,
        nothingAvailable: false,
        searchError: false
      }
    },
    mixins: [ validationMixin ],
    components: {
      AvailablePatientSession
    },
    validations: {
      selected_session: { required }
    },
    created () {
      this.$eventHub.$on('set-selected-session', selected_patient_session => {
        this.selected_session = selected_patient_session
      })

      this.$eventHub.$on('book-appointment-for-user', user => {
        this.user = user
      })
    },
    beforeDestroy () {
      this.$eventHub.$off('set-selected-session')
      this.$eventHub.$off('book-appointment-for-user')
    },
    methods: {
      closeAppointmentForm () {
        this.searchDate = ''
        this.availablePatientSessions = []
        this.selected_session = {}
        this.user = {}
        this.searchError = false
        this.saveError = false
        this.nothingAvailable = false

        this.$root.$emit('bv::hide::modal', 'appointmentForm')
      },
      searchForAvailablePatientSessions () {
        this.selected_session = {}
        this.nothingAvailable = false
        this.searchError = false

        let searchParams = {
          search_date: this.searchDate,
          available_only: true
        }

        let promise = this.$http.get('/admin/patient_sessions.json', { params: searchParams })

        return promise.then((data) => {
          this.availablePatientSessions = data.body
          this.nothingAvailable = this.availablePatientSessions.length == 0
        }).catch(error => {
          this.searchError = true
        })
      },
      handleOk (event) {
        event.preventDefault()
        this.saveError = false

        let appointmentParams = {
          patient_session_id: this.selected_session.id,
          user_id: this.user.id
        }

        let promise = this.$http.post('/admin/appointments.json', { appointment: appointmentParams })

        return promise.then((data) => {
          this.closeAppointmentForm()
          this.saveError = false
          this.$eventHub.$emit('new-appointment', data.body)
        }).catch(error => {
          this.saveError = true
        })
      }
    }
  }
</script>

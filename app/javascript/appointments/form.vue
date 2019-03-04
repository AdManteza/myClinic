<template>
  <div>
    <b-modal scrollable
             size="xl"
             id="appointmentForm"
             :title="modal_title"
             :ok-title="processing_booking_text"
             :ok-disabled="$v.selected_session.$invalid || processingBooking"
             @cancel="closeAppointmentForm"
             @ok="handleOk">
      <b-alert show dismissible variant="danger" v-if="saveError">
        <p>There was a problem booking your appointment. Please try again. If problem persists, please contact Technical Support.</p>
      </b-alert>
      <b-row align-h="center">
        <b-col cols="4" class="pl-5">
          <Datepicker v-model.trim="searchDate"
                      bootstrap-styling
                      inline
                      @selected="clearPatientSessions()"
                      @changedMonth="clearPatientSessions()"
                      @changedYear="clearPatientSessions()"
                      @changedDecade="clearPatientSessions()"
                      >
          </Datepicker>
          <b-button @click="searchForAvailablePatientSessions()"
                    :disabled="searching"
                    size="sm"
                    text="Search"
                    variant="success"
                    class="search-sessions mt-2">
            {{ search_button_text }}
          </b-button>
        </b-col>
        <b-col cols="8" class="pr-2">
          <b-alert show dismissible variant="warning" class="mt-4" v-if="nothingAvailable">
            <p>Unfortunately there are no available sessions based on your selected date. Please try again</p>
          </b-alert>
          <b-form-radio-group>
            <AvailablePatientSession class="available-patient-session" :session="session" v-for="session in availablePatientSessions" :key="session.id"></AvailablePatientSession>
          </b-form-radio-group>
        </b-col>
      </b-row>
    </b-modal>
  </div>
</template>
<script>
  import { validationMixin } from 'vuelidate'
  import { required } from 'vuelidate/lib/validators'
  import AvailablePatientSession from '../patient_sessions/available.vue'
  import Datepicker from 'vuejs-datepicker'

  export default {
    data () {
      return {
        user: {},
        selected_session: {},
        searchDate: new Date,
        availablePatientSessions: [],
        saveError: false,
        nothingAvailable: false,
        searching: false,
        processingBooking: false,
        searchError: false
      }
    },
    computed: {
      search_button_text () {
        return (this.searching ? 'Searching...' : 'Search')
      },
      processing_booking_text () {
        return (this.processingBooking ? 'Booking...' : 'Book')
      },
      modal_title () {
        return `Book an Appointment for ${this.user.full_name}`
      }
    },
    mixins: [ validationMixin ],
    components: {
      AvailablePatientSession, Datepicker
    },
    validations: {
      selected_session: { required },
      searchDate: { required }
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
      clearPatientSessions () {
        this.availablePatientSessions = []
        this.selected_session = {}
        this.nothingAvailable = false
      },
      closeAppointmentForm () {
        this.clearPatientSessions()
        this.searchDate = ''
        this.user = {}
        this.searchError = false
        this.saveError = false

        this.$root.$emit('bv::hide::modal', 'appointmentForm')
      },
      searchForAvailablePatientSessions () {
        this.clearPatientSessions()
        this.searchError = false
        this.searching = true

        let searchParams = {
          search_date: this.searchDate.toString(),
          available_only: true
        }

        let promise = this.$http.get('/admin/patient_sessions.json', { params: searchParams })

        return promise.then((data) => {
          this.searching = false
          this.availablePatientSessions = data.body
          this.nothingAvailable = this.availablePatientSessions.length == 0
        }).catch(error => {
          this.searchError = true
          this.searching = false
        })
      },
      handleOk (event) {
        event.preventDefault()
        this.saveError = false
        this.processingBooking = true

        let appointmentParams = {
          patient_session_id: this.selected_session.id,
          user_id: this.user.id
        }

        let promise = this.$http.post('/admin/appointments.json', { appointment: appointmentParams })

        return promise.then((data) => {
          this.processingBooking = false
          this.saveError = false
          this.closeAppointmentForm()
          this.$eventHub.$emit('new-appointment', data.body)
        }).catch(error => {
          this.processingBooking = false
          this.saveError = true
        })
      }
    }
  }
</script>

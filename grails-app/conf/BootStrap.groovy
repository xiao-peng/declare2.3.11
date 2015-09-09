import com.bjrxht.converters.marshaller.json.TableDomainClassMarshaller
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SecurityFilterPosition
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class BootStrap {
    def authenticationManager
    def concurrentSessionController
    def securityContextPersistenceFilter
    def init = { servletContext ->
        SpringSecurityUtils.clientRegisterFilter('concurrencyFilter', SecurityFilterPosition.CONCURRENT_SESSION_FILTER)
        JSON.registerObjectMarshaller(new TableDomainClassMarshaller(false, true, 10));
    }
    def destroy = {
    }
}

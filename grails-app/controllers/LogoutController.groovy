
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.security.core.session.SessionRegistry


class LogoutController {
    SessionRegistry  sessionRegistry
    /**
     * Index action. Redirects to the Spring security logout uri.
     */
    def index = {
        // TODO put any pre-logout code here

        sessionRegistry.removeSessionInformation(session?.getId())
        //session.invalidate();
        //sessionRegistry?.allPrincipals
        redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/j_spring_security_logout'
    }
}

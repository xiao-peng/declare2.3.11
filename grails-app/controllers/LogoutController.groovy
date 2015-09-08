import com.bjrxht.cms.core.system.LoginRecord
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.security.core.session.SessionRegistry


class LogoutController {
    SessionRegistry  sessionRegistry
    /**
     * Index action. Redirects to the Spring security logout uri.
     */
    def index = {
        // TODO put any pre-logout code here
        try{
            LoginRecord.withSession {
                def lr=LoginRecord.findBySessionIdAndLogoutTimeIsNull(session?.getId());
                if(lr){
                    lr.logoutTime=new Date();
                    lr.save(flush: true);
                }
            }

        }catch(e){

        }

        sessionRegistry.removeSessionInformation(session?.getId())
        //session.invalidate();
        //sessionRegistry?.allPrincipals
        redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/j_spring_security_logout'
    }
}

import com.bjrxht.cache.SpringSecurityKeyGenerator
import org.springframework.security.core.session.SessionRegistryImpl
import org.springframework.security.web.authentication.session.ConcurrentSessionControlStrategy
import org.springframework.security.web.session.ConcurrentSessionFilter
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter


// Place your Spring DSL code here
beans = {
    webCacheKeyGenerator(SpringSecurityKeyGenerator)
    sessionRegistry(SessionRegistryImpl)

    concurrencyFilter(ConcurrentSessionFilter) {
        sessionRegistry = sessionRegistry
        logoutHandlers = [ref("rememberMeServices"), ref("securityContextLogoutHandler")]
        expiredUrl='/login/concurrentSession'
    }

    sessionAuthenticationStrategy(ConcurrentSessionControlStrategy, sessionRegistry) {
        maximumSessions = -1             //-1 为不限   不可为0
        alwaysCreateSession = true
        exceptionIfMaximumExceeded=false  // true 为后登陆用户异常，false 为先登陆用户被踢出
    }
    /*
    concurrentSessionControlStrategy(ConcurrentSessionControlStrategy, sessionRegistry) {
        alwaysCreateSession = true
        exceptionIfMaximumExceeded = false
        maximumSessions = 1
    }
     */
    // Better not to override the bean but to just set the strategy in Bootstrap.groovy (Details  below)
    /*
    authenticationProcessingFilter(UsernamePasswordAuthenticationFilter) {
      sessionAuthenticationStrategy=concurrentSessionControlStrategy
      authenticationManager=ref("authenticationManager")
    }
    */
}

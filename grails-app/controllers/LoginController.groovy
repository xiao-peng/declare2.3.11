import com.bjrxht.core.BaseUser
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.WebAttributes
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.security.web.authentication.session.SessionAuthenticationException

import javax.servlet.http.HttpServletResponse

class LoginController {
    def daoAuthenticationProvider
    def mailService
    /**
     * Dependency injection for the authenticationTrustResolver.
     */
    def authenticationTrustResolver

    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService

    /**
     * Default action; redirects to 'defaultTargetUrl' if logged in, /login/auth otherwise.
     */
    def index = {
        if (springSecurityService.isLoggedIn()) {
            redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
        } else {
            redirect action: 'auth', params: params
        }
    }

    /**
     * Show the login page.
     */
    def auth = {

        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            redirect uri: config.successHandler.defaultTargetUrl
            return
        }

        String view = 'auth'
        view="/declares/${session.getAttribute('declareRenderingUri')}/auth"
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl,rememberMeParameter: config.rememberMe.parameter]
    }

    /**
     * The redirect action for Ajax requests.
     */
    def authAjax = {
        response.setHeader 'Location', SpringSecurityUtils.securityConfig.auth.ajaxLoginFormUrl
        response.sendError HttpServletResponse.SC_UNAUTHORIZED
    }

    /**
     * Show denied page.
     */
    def denied = {
        if (springSecurityService.isLoggedIn() &&
                authenticationTrustResolver.isRememberMe(SecurityContextHolder.context?.authentication)) {
            // have cookie but the page is guarded with IS_AUTHENTICATED_FULLY
            redirect action: 'full', params: params
        }
    }

    /**
     * Login page for users with a remember-me cookie but accessing a IS_AUTHENTICATED_FULLY page.
     */
    def full = {
/*        //虽然可以登录，但无法计入loginRecod表和sessionRegister，还是应该在requestmap中配置 url 'IS_AUTHENTICATED_FULLY,IS_AUTHENTICATED_REMEMBERED'
        if(springSecurityService.currentUser?.username){
            def user=BaseUser.get(springSecurityService.currentUser?.id)
            def auth = new UsernamePasswordAuthenticationToken(user.username,null);
            def authtoken = daoAuthenticationProvider.authenticate(auth)
            SCH.context?.authentication = authtoken
        }*/
        def config = SpringSecurityUtils.securityConfig
        String view='auth'
        view="/declares/${session.getAttribute('declareRenderingUri')}/auth"
        render view: view, params: params,
                model: [hasCookie: authenticationTrustResolver.isRememberMe(SecurityContextHolder.context?.authentication),
                        postUrl  : "${request.contextPath}${config.apf.filterProcessesUrl}"]
    }

    /**
     * Callback after a failed login. Redirects to the auth page with a warning message.
     */
    def authfail = {

        def username = session[UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY]
        String msg = ''
        def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        //org.springframework.security.web.authentication.session.SessionAuthenticationException: Maximum sessions of 1 for this principal exceeded
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                msg = g.message(code: "springSecurity.errors.login.expired")
            } else if (exception instanceof CredentialsExpiredException) {
                msg = g.message(code: "springSecurity.errors.login.passwordExpired")
            } else if (exception instanceof DisabledException) {
                msg = g.message(code: "springSecurity.errors.login.disabled")
            } else if (exception instanceof LockedException) {
                msg = g.message(code: "springSecurity.errors.login.locked")
            } else if (exception instanceof SessionAuthenticationException) {
                msg = g.message(code: "springSecurity.errors.login.maximum")
            }else {
                msg = g.message(code: "springSecurity.errors.login.fail")
            }
        }

        if (springSecurityService.isAjax(request)) {
            render([error: msg] as JSON)
        } else {
            flash.message = msg
            redirect action: 'auth', params: params
        }
    }

    /**
     * The Ajax success redirect url.
     */
    def ajaxSuccess = {
        render([success: true, username: springSecurityService.authentication.name] as JSON)
    }

    /**
     * The Ajax denied redirect url.
     */
    def ajaxDenied = {
        render([error: 'access denied'] as JSON)
    }
    def concurrentSession(){
        //println params
        //render 'your concurrentSession'
        flash.message=g.message(code: "springSecurity.errors.login.concurrent.session",default: 'concurrent Session,please login again.')
        redirect(action: auth)
    }

    def forgetPass(){

    }
    def resetPass(){

    }

    def html(){
        if(!params.HTMLname){
            render 'bad request'
            return false;
        }
        if(!params.HTMLcode){
            params.HTMLcode=(String)session.getAttribute('declareRenderingUri');
        }
        def currentUser=springSecurityService.currentUser;
        //def declare=Declare.findByCode(params.HTMLcode);
        render (view:"/declares/${params.HTMLcode}/${params.HTMLname}",
                model: ['currentUser':currentUser])
    }
}

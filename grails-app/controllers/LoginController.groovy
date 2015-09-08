import com.bjrxht.cms.core.BaseUser
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
        render view: 'auth', params: params,
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
        def map=[:]
        def user=BaseUser.findByUsername(params.email);
        if(user.phone==params.phone){
            long newPass=new Random().nextLong(999999999l - 100000000l + 1) + 100000000l;
            user.password="${newPass}";
            user.save(flush: true);
            map.result=true;
            map.message="";
            map.url="http://mail."+params.email.tokenize('@')[1];

            String path = request.getContextPath();
            String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
            def url = "${basePath}login/auth";
            def timer=new Timer();
            timer.runAfter(1*1000){
                try {
                    String htmlStr = """
                <div style="border:1px solid #eeeeee;padding:15px;width:620px">

                    <div style="width:100%;text-align:right;" ></div>
                    <div style="width:100%;text-align:left;line-height:20px;text-indent: 2em;padding-top:25px" >尊敬的用户：${user.username}</div>
                    <div style="width:100%;text-align:left;line-height:25px;text-indent: 2em;padding-top:20px" >我们已经收到您的忘记密码重设信息，你的系统密码重设为${newPass}，请及时登录系统重置。<br/>
                    点击下面的确认链接即可登录系统：
                    <a href="${url}" target="_blank">点击这里登录</a></div>
<div style="width:100%;text-align:left;line-height:25px;text-indent: 2em;padding-top:15px" >如果您的邮件阅读程序不支持点击，请将上面的地址拷贝至您的浏览器（例如IE）地址栏后打开。</div>
<div style="width:100%;text-align:left;line-height:25px;text-indent: 2em;padding-top:15px" >
<a href="${url}" target="_blank" style="line-height:25px;">${url}</a>
</div>
 <div style="width:100%;text-align:left;line-height:20px;padding-top:15px;text-indent: 2em;" >
 欢迎您马上登录<A href="${basePath}" target="_blank">${basePath}</A>发布需求、寻找项目，希望您与我们一起，见证彼此成长！</div>
</div>
                </div>
                """
                    mailService.sendMail({
                        to bu.email
                        from grailsApplication.config.grails.mail.username
                        subject "用户忘记密码重设"
                        html htmlStr
                    });
                }catch (e){}
            }
        }else{
            map.result=false;
            map.message="";
        }
        render map as JSON;
    }
}

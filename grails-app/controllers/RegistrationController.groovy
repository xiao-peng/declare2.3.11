

import com.bjrxht.core.BaseRole
import com.bjrxht.core.BaseUser
import com.bjrxht.core.BaseUserBaseRole
import com.bjrxht.declare.Declare
import com.bjrxht.declare.Register
import grails.converters.JSON

class RegistrationController {
    def springSecurityService
    def mailService
    def index(){
        if(springSecurityService.isLoggedIn()) {
            redirect(controller: 'workspace',action: 'index')
        } else {
           return
        }
    }
    def checkmail(){
        def isOk=false;
        def data=[:]
        if(params.name && BaseUser.countByUsername(params.name)==0){
            isOk=true
        }
        render "${isOk}"
        return
    }
    def registerSave(){
        def map=[:]
        if(BaseUser.countByUsername(params.email)>0){
            map.result=false;
            map.message="此邮箱已注册";
        }else{
            def bu=new BaseUser(username: params.email,enabled: false,password: params.password,firstName:params.firstName,lastName:params.lastName,email:params.email,phone:params.phone,type: params.type);
            bu.save(flush: true);
            if(bu.errors.allErrors.size()==0){
                BaseUserBaseRole.create(bu,BaseRole.findByAuthority('ROLE_USER'),true);
                def declare=Declare.findByCode(params.HTMLcode);
                if(declare){
                    def reg=new Register();
                    reg.declare=declare;
                    reg.baseUser=bu;
                    if(reg.save(flush: true)&&reg.errors.allErrors.size()==0){
                        map.result=true;
                        map.url="http://mail."+params.email.tokenize('@')[1];
                        String path = request.getContextPath();
                        String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
                        def url = "${basePath}registration/active?token="+bu.id;
                        def timer=new Timer();
                        timer.runAfter(1*1000){
                            try {
                                String htmlStr = """
                        <div style="border:1px solid #eeeeee;padding:15px;width:1000px">

                            <div style="width:100%;text-align:right;" ></div>
                            <div style="width:100%;text-align:left;line-height:20px;text-indent: 2em;padding-top:25px" >尊敬的用户：${bu.username}</div>
                            <div style="width:100%;text-align:left;line-height:25px;text-indent: 2em;padding-top:20px" >我们已经收到您的注册信息，
                            点击下面的确认链接即可激活您的注册用户账号：
                            <a href="${url}" target="_blank">点击这里，立即激活账号</a></div>
        <div style="width:100%;text-align:left;line-height:25px;text-indent: 2em;padding-top:15px" >如果您的邮件阅读程序不支持点击，请将上面的地址拷贝至您的浏览器（例如IE）地址栏后打开。</div>
        <div style="width:100%;text-align:left;line-height:25px;text-indent: 2em;padding-top:15px" >
        <a href="${url}" target="_blank" style="line-height:25px;">${url}</a>
        </div>
         <div style="width:100%;text-align:left;line-height:20px;padding-top:15px;text-indent: 2em;" >
         欢迎您马上登录<A href="${basePath}" target="_blank">${basePath}</A>申报信息！</div>
        </div>
                        </div>
                        """
                                mailService.sendMail({
                                    to bu.email
                                    from grailsApplication.config.grails.mail.username
                                    subject "注册用户激活"
                                    html htmlStr
                                });

                            }catch (e){}
                        }
                    }
                }
            }else{
                map.result=false;
                map.message=bu.errors.allErrors.toString();
            }
        }
        //render map as JSON;
        render "${map as JSON}"

    }
    def active(){
        def token = params.token
        def user = BaseUser.get(token)
        if(user){
            if(user.enabled){
            }
            else{
                user.enabled=true
                user.save(flush: true)
            }
        }
        flash.message="您的注册用户帐号激活成功！"
        redirect(uri: "/login/auth")
    }
}

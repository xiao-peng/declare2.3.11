package com.bjrxht.declare

import com.bjrxht.core.*
import grails.converters.JSON
import grails.plugins.springsecurity.SpringSecurityService
import org.codehaus.groovy.grails.commons.ApplicationHolder

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

class DeclareController {
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def messageSource
    def mailService
    SpringSecurityService springSecurityService
    def index() {
        redirect(action: 'list')
    }
    def list(){

    }
    def js(){

    }
    def json(){
        params.max = Math.min(params.limit ? params.int('limit') : 10, 100);
        params.limit=params.max;
        if(!params.offset) params.offset ='0'
        if(!params.sort) params.sort ='id'
        if(!params.order) params.order ='desc'
        def ecCount=Declare.createCriteria().count{
            if(params.search){
                ilike('name',"%${params.search}%");
            }
        }
        def ecList=Declare.createCriteria().list{
            if(params.search){
                ilike('name',"%${params.search}%");
            }
            order(params.sort,params.order)
            maxResults(params.max.toInteger())
            firstResult(params.offset.toInteger())
        }
        def map=[:];
        map.total=ecCount;
        map.rows=ecList;
        render map as JSON;
    }
    def serverSave(){
        def map=[:];
        if(!params.id){
            map=this.save();
        }else{
            map=this.update(params.id?.toLong());
        }
        render "${(map as JSON).toString()}"   //此样式支持IE9
    }
    def save() {
        def map=[:];
        def dateMap=[:];
        ApplicationHolder.application.getDomainClass(Declare.name).getPersistentProperties().toList().each{p->
            if(p.type == java.util.Date.class){
                if(params."${p.name}"){
                    dateMap."${p.name}"=params."${p.name}";
                    params."${p.name}"='';
                }
            }
        }
        def oneInstance = new Declare();
        oneInstance.properties=params;
        if (!oneInstance.save(flush: true) ) {
            println oneInstance.errors
            map.result=false;
            def message='';
            oneInstance.errors.allErrors.each{error->
                message=message+messageSource.getMessage(error.code,error.arguments,error.defaultMessage,new Locale("zh_CN"))+"<br/>";
            }
            map.message=message;
        }else{
            flash.message = message(code: 'default.created.message', args: [message(code: 'catalog.label', default: 'Declare'), oneInstance.id])
            map.result=true;
            map.message=flash.message;
        }
        return map;
    }
    def update(Long id) {
        def map = [:];
        def dateMap=[:];
        ApplicationHolder.application.getDomainClass(Declare.name).getPersistentProperties().toList().each{p->
            if(p.type == java.util.Date.class){
                if(params."${p.name}"){
                    dateMap."${p.name}"=params."${p.name}";
                    params."${p.name}"='';
                }
            }
        }
        def oneInstance = Declare.get(id)
        if (!oneInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'catalog.label', default: 'Declare'), id])
            map.result = false;
            map.message = flash.message;
            return map;
        }
        oneInstance.properties = params
        if (!oneInstance.save(flush: true)) {
            map.result = false;
            def message='';
            oneInstance.errors.allErrors.each{error->
                message=message+messageSource.getMessage(error.code,error.arguments,error.defaultMessage,new Locale("zh_CN"))+"<br/>";
            }
            map.message=message;
            return map;
        }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'catalog.label', default: 'Declare'), oneInstance.id])
        map.result = true;
        map.message = flash.message;
        return map;
    }
    def deleteAll(){
        def map=[:]
        def list=params.ids.tokenize(',');
        list.each {
            def oneInstance = Declare.get(it);
            if(oneInstance){
                oneInstance.delete(flush: true);
            }
        }
        flash.message = message(code: 'default.deleted.message')
        map.result=true;
        map.message=flash.message;
        render map as JSON;
    }
    def html(){
        def currentUser=springSecurityService.currentUser;
        def declare=Declare.findByCode(params.HTMLcode);
        render (view:"/declares/${params.HTMLcode}/${params.HTMLname}",
                model: ['currentUser':currentUser,'declare':declare])
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
                        def url = "${basePath}declare/active?token="+bu.id;
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
    private void nocache(response) {
        response.setHeader('Cache-Control', 'no-cache') // HTTP 1.1
        response.addDateHeader('Expires', 0)
        response.setDateHeader('max-age', 0)
        response.setIntHeader ('Expires', -1) //prevents caching at the proxy server
        response.addHeader('cache-Control', 'private') //IE5.x only
    }


}

package com.bjrxht.declare

import com.bjrxht.core.*
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class WorkspaceController {
    def springSecurityService;
    def index() { }

    //获取用户头像
    def userAviator(){
        def currentUser=BaseUser.get(springSecurityService.currentUser?.id);
        if(params.username){
            currentUser=BaseUser.findByUsername(params.username)
        }
        def bytes=[];
        if(currentUser?.aviator && currentUser?.aviator?.size()>0){
            bytes=currentUser.aviator;
        }else{
            def file=new File(request.servletContext.getRealPath("/js/template/atlant/less/assets/images/users/no-image.jpg"));
            bytes=file.bytes;
        }
        try{
            response.setContentType("image/jpeg");
            response.setContentLength(bytes.size())
            response.setHeader('filename', "aviator.jpg")
            OutputStream out = response.outputStream
            out.write(bytes)
            out.close()
            return;
        }catch(Exception e){
            //log.error 'user give up download the pic file !'
            render "user give up download the pic file !"
            return
        }
    }

    def changeSkin(){
        def currentUser=BaseUser.get(springSecurityService.currentUser?.id);
        if(params.skin){
            currentUser.skin=params.skin;
            currentUser.save(flush: true);
        }
        def map=[:]
        map.result=true
        render map as JSON;
    }
    def changePassword(){
        def map=[:]
        def currentUser=BaseUser.get(springSecurityService.currentUser?.id);
        if(springSecurityService.encodePassword(params.old)==currentUser.password){
            if(params.new1==params.new2){
                currentUser.password=params.new1;
                currentUser.save(flush: true);
                map.message="修改成功";
                map.result=true;
            }else{
                map.message="确认密码与新密码不一致";
                map.result=false;
            }
        }else{
            map.message="密码不正确";
            map.result=false;
        }
        render map as JSON;
    }
    def profile(){
        return [currentUser:springSecurityService.currentUser]
    }
    def getPersonProfile(){
        def currentUser
        if(params.id){
            currentUser=BaseUser.get(params.id)
        }else{
            currentUser=springSecurityService.currentUser
        }
        return [currentUser:currentUser]
    }
    def saveProfile(){
        def currentUser=BaseUser.get(springSecurityService.currentUser?.id);
        def map=[:]
        if(currentUser.id!=params.id){
            map.result=false;
            map.message="与当前用户标识不符";
        }else{
            currentUser.properties=params;
            currentUser.save(flush: true);
            if(SpringSecurityUtils.ifAllGranted("ROLE_MEMBER")){
                BaseUserBaseRole.withTransaction {status->
                    try{
                        BaseUserBaseRole.removeAll(currentUser);
                        BaseUserBaseRole.create(currentUser,BaseRole.findByAuthority("ROLE_USER"));
                        springSecurityService.reauthenticate(currentUser.username);
                        map.changeRole=true;
                    }catch(e){
                        println e.message
                        status.setRollbackOnly()
                    }

                }
            }
            map.result=true;
        }
        render map as JSON;
    }
    private String getIpAddr(request) {
        String ip = request.getHeader("x-forwarded-for");
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

}

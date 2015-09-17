package com.bjrxht.declare

import com.bjrxht.core.BaseRole
import com.bjrxht.core.BaseUser
import com.bjrxht.core.BaseUserBaseRole
import grails.converters.JSON
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class WebController {
    def springSecurityService;
    def index() { }
    def html(){
        if(!params.HTMLcode){
            params.HTMLcode=(String)session.getAttribute('declareRenderingUri');
        }
        def currentUser=springSecurityService.currentUser;
        //def declare=Declare.findByCode(params.HTMLcode);
        render (view:"/declares/${params.HTMLcode}/${params.HTMLname}",
                model: ['currentUser':currentUser])
    }

}

package com.bjrxht.core

import com.bjrxht.poi.ExcelReadBuilder
import grails.converters.JSON

class BaseUserController {
    def messageSource
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
        def role;
        def userIds;
        if(params.role){
            role=BaseRole.findByAuthority(params.role);
            userIds=BaseUserBaseRole.executeQuery("select distinct baseUser.id from BaseUserBaseRole b where b.baseRole=:baseRole",['baseRole':role]);
            if(!userIds || userIds?.size()==0){
                userIds=['-1'];
            }
        }
        def ecCount=BaseUser.createCriteria().count{
            if(params.search){
                ilike('email',"%${params.search}%");
            }
            if(params.role){
                'in'('id',userIds)
            }
        }

        def ecList=BaseUser.createCriteria().list{
            if(params.search){
                ilike('email',"%${params.search}%");
            }
            if(params.role){
                'in'('id',userIds)
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
    def importExcel(){
        def map=[:];
        def file = request.getFile('file');
        if(file ||!file?.empty) {  //file.originalFilename
            try{
                def list1=[];
                def list2=[];
                new ExcelReadBuilder(2003,file.bytes).eachLine([sheet:'sheet1',labels:true]) {
                    if(it.rowNum>2){
                        println "${it.rowNum},${cell[0]},${cell[1]},${cell[2]},${cell[3]}......"
                    }
                }
                map.result=true;
            }catch(e){
                map.result=false;
                map.message=e.message;
            }
        }else{
            map.result=false;
            map.message="file is empty!";
        }
        render "${(map as JSON).toString()}"   //此样式支持IE9
    }
    def serverSave(){
        def map=[:];
        if(!params.version){
            params.version=0l;
        }
        if(!params.id){
            map=this.save();
        }else{
            map=this.update(params.id,params.version?.toLong()?:0);
        }
        render "${(map as JSON).toString()}"   //此样式支持IE9
    }
    def save() {
        def map=[:];
        def baseUserInstance = new BaseUser();
        baseUserInstance.properties=params;
        if (!baseUserInstance.save(flush: true) ) {
            map.result=false;
            def message='';
            baseUserInstance.errors.allErrors.each{error->
                message=message+messageSource.getMessage(error.code,error.arguments,error.defaultMessage,new Locale("zh_CN"))+"<br/>";
            }
            map.message=message;
        }else{
            if(request.getParameterValues('roles')){
                BaseUserBaseRole.removeAll(baseUserInstance);
                request.getParameterValues('roles').each{roleId->
                    BaseUserBaseRole.create(baseUserInstance,BaseRole.get(roleId),true)
                }
            }
            flash.message = message(code: 'default.created.message', args: [message(code: 'baseUser.label', default: 'BaseUser'), baseUserInstance.id])
            map.result=true;
            map.message=flash.message;
        }
        return map;
    }
    def update(String id, Long version) {
        def map = [:];
        BaseUser baseUserInstance = BaseUser.get(id)
        if (!baseUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'baseUser.label', default: 'BaseUser'), id])
            map.result = false;
            map.message = flash.message;
            return map;
        }
        baseUserInstance.properties = params
        if (!baseUserInstance.save(flush: true)) {
            map.result = false;
            def message='';
            baseUserInstance.errors.allErrors.each{error->
                message=message+messageSource.getMessage(error.code,error.arguments,error.defaultMessage,new Locale("zh_CN"))+"<br/>";
            }
            map.message=message;
            return map;
        }
        if(request.getParameterValues('roles')){
            BaseUserBaseRole.removeAll(baseUserInstance);
            request.getParameterValues('roles').each{roleId->
                BaseUserBaseRole.create(baseUserInstance,BaseRole.get(roleId),true)
            }
        }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'baseUser.label', default: 'BaseUser'), baseUserInstance.id])
        map.result = true;
        map.message = flash.message;
        return map;
    }
    def deleteAll(){
        def map=[:]
        def list=params.ids.tokenize(',');
        list.each {
            def oneInstance = BaseUser.get(it.toLong());
            oneInstance.delete(flush: true);
        }
        flash.message = message(code: 'default.deleted.message')
        map.result=true;
        map.message=flash.message;
        render map as JSON;
    }

def endableOne(){

    def map=[:]
    def user=BaseUser.get(params.id)

    user.enabled=true

    user.save(flush: true)
    map.result=true;
    render map as JSON;
}


    def disableOne(){
        def map=[:]
        def user=BaseUser.get(params.id)

        user.enabled=false

        user.save(flush: true)
        map.result=true;
        render map as JSON;
    }
    def getOneUserRoles(){
        def map=[:]
        map.roles='';
        def user=BaseUser.get(params.id)
        if(user){
            map.roles=user.authorities.collect{it.id};
        }
        render map as JSON;
    }
}

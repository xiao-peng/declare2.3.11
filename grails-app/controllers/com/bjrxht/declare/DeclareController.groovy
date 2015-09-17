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


    private void nocache(response) {
        response.setHeader('Cache-Control', 'no-cache') // HTTP 1.1
        response.addDateHeader('Expires', 0)
        response.setDateHeader('max-age', 0)
        response.setIntHeader ('Expires', -1) //prevents caching at the proxy server
        response.addHeader('cache-Control', 'private') //IE5.x only
    }


}

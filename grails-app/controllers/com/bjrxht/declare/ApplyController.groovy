package com.bjrxht.declare

import grails.converters.JSON
import grails.plugins.springsecurity.SpringSecurityService

class ApplyController {
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def messageSource
    SpringSecurityService springSecurityService
    def index() {
        redirect(action: 'list')
    }
    def list(){

    }
    def js(){

    }
    def json={
        params.max = Math.min(params.limit ? params.int('limit') : 10, 100);
        params.limit=params.max;
        if(!params.offset) params.offset ='0'
        if(!params.sort) params.sort ='id'
        if(!params.order) params.order ='desc'
        def ecCount=Apply.createCriteria().count{
            if(params.search){
                ilike('name',"%${params.search}%");
            }
        }
        def ecList=Apply.createCriteria().list{
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

    def save= {
        nocache(response)
        def map=[:];
        def oneInstance = new Apply();
        oneInstance.properties=params;
        if (!oneInstance.save(flush: true) ) {
            map.result=false;
            def message='';
            oneInstance.errors.allErrors.each{error->
                message=message+messageSource.getMessage(error.code,error.arguments,error.defaultMessage,new Locale("zh_CN"))+"<br/>";
            }
            map.message=message;
        }else{
            flash.message = message(code: 'default.created.message', args: [message(code: 'apply.label', default: 'Apply'), oneInstance.id])
            map.result=true;
            map.message=flash.message;
        }
        return map;
    }
    def update= {
        nocache(response)
        def map = [:];
        def oneInstance = Apply.get(params.id)
        if (!oneInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apply.label', default: 'Apply'), id])
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
        flash.message = message(code: 'default.updated.message', args: [message(code: 'apply.label', default: 'Apply'), oneInstance.id])
        map.result = true;
        map.message = flash.message;
        return map;
    }
    def deleteAll={
        def map=[:]
        def list=params.ids.tokenize(',');
        list.each {
            def oneInstance = Apply.get(params.id);
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

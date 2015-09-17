<%=packageName ? "package ${packageName}\n\n" : ''%>

import com.bjrxht.poi.ExcelReadBuilder
import grails.plugins.springsecurity.SpringSecurityService
import org.springframework.dao.DataIntegrityViolationException

import grails.converters.JSON
<%
String idType='Long'
if(domainClass.properties.find {it.name=='id'}.type==java.lang.String){
    idType='String'
}
%>

class ${className}Controller {
    def messageSource;
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
        <%
        def str='name';
        def one=domainClass.properties.find{it.type==String};
        if(one){
            str=one.name
        }
        %>
        def ecCount=${className}.createCriteria().count{
            if(params.search){
                ilike('${str}',"%\${params.search}%");
            }
        }
        def ecList=${className}.createCriteria().list{
            if(params.search){
                ilike('${str}',"%\${params.search}%");
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
                        println "\${it.rowNum},\${cell[0]},\${cell[1]},\${cell[2]},\${cell[3]}......"
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
        render "\${(map as JSON).toString()}"   //此样式支持IE9
    }
    def serverSave(){
        def map=[:];
        if(!params.version){
            params.version=0l;
        }
        if(!params.id){
            map=this.save();
        }else{
            map=this.update(params.id?.toLong(),params.version?.toLong()?:0);
        }
        render "\${(map as JSON).toString()}"   //此样式支持IE9
    }
    def save() {
        def map=[:];
        def ${propertyName} = new ${className}();
        ${propertyName}.properties=params;
        if (!${propertyName}.save(flush: true) ) {
            map.result=false;
            def message='';
            ${propertyName}.errors.allErrors.each{error->
                message=message+messageSource.getMessage(error.code,error.arguments,error.defaultMessage,new Locale("zh_CN"))+"<br/>";
            }
            map.message=message;
        }else{

            flash.message = message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
            map.result=true;
            map.message=flash.message;
        }
        return map;
    }
    def update(Long id, Long version) {
        def map = [:];
        ${className} ${propertyName} = ${className}.get(id)
        if (!${propertyName}) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), id])
            map.result = false;
            map.message = flash.message;
            return map;
        }
        ${propertyName}.properties = params
        if (!${propertyName}.save(flush: true)) {
            map.result = false;
            def message='';
            ${propertyName}.errors.allErrors.each{error->
                message=message+messageSource.getMessage(error.code,error.arguments,error.defaultMessage,new Locale("zh_CN"))+"<br/>";
            }
            map.message=message;
            return map;
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        map.result = true;
        map.message = flash.message;
        return map;
    }
    def deleteAll(){
        def map=[:]
        def list=params.ids.tokenize(',');
        list.each {
            def oneInstance = ${className}.get(it.toLong());
            oneInstance.delete(flush: true);
        }
        flash.message = message(code: 'default.deleted.message')
        map.result=true;
        map.message=flash.message;
        render map as JSON;
    }


}

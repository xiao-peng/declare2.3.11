import com.bjrxht.converters.marshaller.json.TableDomainClassMarshaller
import com.bjrxht.declare.Declare
import grails.converters.JSON

import org.codehaus.groovy.grails.plugins.springsecurity.SecurityFilterPosition
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import com.bjrxht.core.*

class BootStrap {
    def authenticationManager
    def concurrentSessionController
    def securityContextPersistenceFilter
    def init = { servletContext ->
        SpringSecurityUtils.clientRegisterFilter('concurrencyFilter', SecurityFilterPosition.CONCURRENT_SESSION_FILTER)
        JSON.registerObjectMarshaller(new TableDomainClassMarshaller(false, true, 10));
        if(BaseUser.count()==0){
            createRole();
            createDefaultUsers();
            createRequestMap();
            creatDeclares();
            createUsers();
        }
    }
    def destroy = {
    }

    private createRole(){
        def roles=[
                ['IS_AUTHENTICATED_ANONYMOUSLY','匿名用户'],
                ['IS_AUTHENTICATED_FULLY','登录用户'],
                ['IS_AUTHENTICATED_REMEMBERED','缓存用户'],
                ['ROLE_ADMIN','系统管理员'],
                ['ROLE_MANAGER','申报事项管理员'],
                ['ROLE_USER','申报用户'] ,
                ['ROLE_EXPERT','初评专家'],
                ['ROLE_AUDIT_EXPERT','评审专家']
        ];
        roles.each{
            if (!BaseRole.findByAuthority(it[0])) {
                def role=new BaseRole(name:it[0],authority:it[0],description:it[1]);
                role.id=it[0];
                role.save(flush: true)
            }
        }
    }
    def createDefaultUsers() {
        def admin = BaseUser.findByUsername('admin')
        if (!admin) {
            admin = new BaseUser(email: 'admin@bjrxht.com',firstName: '',lastName: 'admin',username:'admin',password: 'admin',enabled:true,accountExpired:false,accountLocked:false,passwordExpired:false)
            admin.save(flush: true)
        }
        new BaseUserBaseRole(baseUser:admin,baseRole:BaseRole.findByAuthority('ROLE_ADMIN')).save(flush: true);

    }
    private def createRequestMap() {
        new Requestmap(url: '/js/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/imgFile/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/ocr/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/images/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/plugins/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/css/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/login/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/logout/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/favicon.ico', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/images/favicon.ico', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/register/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/j_spring_security_check', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/documents/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/baseUser/**', configAttribute: 'ROLE_ADMIN').save(flush: true)
        new Requestmap(url: '/expert/**', configAttribute: 'ROLE_EXPERT,ROLE_AUDIT_EXPERT').save(flush: true)
        new Requestmap(url: '/pdf/**', configAttribute: 'IS_AUTHENTICATED_FULLY').save(flush: true)
        new Requestmap(url: '/', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)
        new Requestmap(url: '/uploads/**', configAttribute: 'IS_AUTHENTICATED_ANONYMOUSLY').save(flush: true)

        new Requestmap(url: '/**', configAttribute: 'IS_AUTHENTICATED_FULLY').save(flush: true)

    }

    private void creatDeclares(){
        def declare=new Declare(name:'申报示例',code:'declare1',domainName: 'localhost',regBeginDate: new Date(),regEndDate: new Date()+30,applyBeginDate: new Date(),applyEndDate: new Date()+60);
        declare.save(flush: true)
    }
    private void createUsers(){

    }
}

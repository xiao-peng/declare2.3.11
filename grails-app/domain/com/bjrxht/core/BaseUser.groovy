package com.bjrxht.core


import com.bjrxht.grails.annotation.Title

@Title(zh_CN='用户表')
class BaseUser {//implements org.activiti.engine.identity.User {
    transient springSecurityService
    static auditable = [ignore:['version','aviator']]
   /*add by activiti*/
    String id
    @Title(zh_CN='邮箱')
    String email
    @Title(zh_CN='名')
    String firstName
    @Title(zh_CN='姓')
    String lastName
    @Title(zh_CN='登录名')
    String username
    String password
    //是否启用
    boolean enabled
    //是否账户过期
    boolean accountExpired
    //是否账户锁定
    boolean accountLocked
    //是否密码过期
    boolean passwordExpired


    //
    @Title(zh_CN='皮肤')
   String skin
    @Title(zh_CN='全屏')
    boolean fullScreen=true
   @Title(zh_CN='头像')
   byte[] aviator




   static constraints = {
       username blank: false, unique: true
       password blank: false

       email email: true, blank: false, unique: true
       firstName blank: true
       lastName blank: true

       skin size: 0..50,nullable: true,blank:true
       aviator (nullable:true,size: 0..1024*1024*10)


   }

   static mapping = {
       password column: '`password`'
       id generator: 'uuid'
   }

   Set<BaseRole> getAuthorities() {
       BaseUserBaseRole.findAllByBaseUser(this).collect { it.baseRole } as Set
   }

   def beforeInsert() {
       encodePassword()
   }

   def beforeUpdate() {
       if (isDirty('password')) {
           encodePassword()
       }
   }

   protected void encodePassword() {
       password = springSecurityService.encodePassword(password)
   }
   String toString(){
       return lastName+firstName;
   }
}

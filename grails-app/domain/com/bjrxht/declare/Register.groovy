package com.bjrxht.declare

import com.bjrxht.core.BaseUser
import com.bjrxht.grails.annotation.Title

@Title(zh_CN='注册用户信息表')
class Register {
   BaseUser baseUser
   Date dateCreated
   Date lastUpdated
   static constraints = {



   }

   static mapping = {

   }

}

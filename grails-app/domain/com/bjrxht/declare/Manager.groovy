package com.bjrxht.declare

import com.bjrxht.core.BaseUser
import com.bjrxht.grails.annotation.Title

@Title(zh_CN='申报事项管理员表')
class Manager {
   BaseUser baseUser
   Declare declare
   Date dateCreated
   Date lastUpdated
   static constraints = {
      baseUser(nullable: false,unique: true)
   }

   static mapping = {

   }

}

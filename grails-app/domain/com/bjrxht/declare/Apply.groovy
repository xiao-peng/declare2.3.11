package com.bjrxht.declare

import com.bjrxht.grails.annotation.Title

@Title(zh_CN='在线申报表')
class Apply {
   Register register
   Declare declare
   Date dateCreated
   Date lastUpdated
   static constraints = {
      register(nullable: false,unique: true)
   }

   static mapping = {

   }

}

package com.bjrxht.declare

import com.bjrxht.core.BaseUser
import com.bjrxht.grails.annotation.Title

@Title(zh_CN='专家表')
class Expert {
   BaseUser baseUser
   Date dateCreated
   Date lastUpdated
   static constraints = {



   }

   static mapping = {

   }

}

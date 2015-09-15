package com.bjrxht.declare

import com.bjrxht.grails.annotation.Title

@Title(zh_CN='申报事项表')
class Declare {
   @Title(zh_CN='名称')
   String name
   @Title(zh_CN='标识')
   String code
   @Title(zh_CN='域名')
   String domainName
    @Title(zh_CN='年度')
    Integer year
   @Title(zh_CN='注册起始日期')
   Date regBeginDate
   @Title(zh_CN='注册截止日期')
   Date regEndDate
   @Title(zh_CN='申报起始日期')
   Date applyBeginDate
   @Title(zh_CN='申报截止日期')
   Date applyEndDate
   Date dateCreated
   Date lastUpdated
   static constraints = {
        name(nullable: false,size: 0..500)
        code(nullable: false,size: 0..500)
       domainName(nullable: true,size: 0..500)
       year(nullable: true)
       regBeginDate(nullable: true)
       regEndDate(nullable: true)
       applyBeginDate(nullable: true)
       applyEndDate(nullable: true)

   }

   static mapping = {

   }

}

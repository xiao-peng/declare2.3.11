package com.bjrxht

import com.bjrxht.activiti.*
import com.bjrxht.cms.content.*
import com.bjrxht.cms.core.*
import com.bjrxht.cms.core.system.*
import com.bjrxht.enterprise.*
import org.codehaus.groovy.grails.commons.DefaultGrailsDomainClass;


def classname=[]

classname << com.bjrxht.enterprise.dictionary.AgeGroup.class;
classname << com.bjrxht.enterprise.dictionary.BusinessType.class;
classname << com.bjrxht.enterprise.dictionary.CategoryType.class;
classname << com.bjrxht.enterprise.dictionary.Demands.class;
classname << com.bjrxht.enterprise.dictionary.DocumentType.class;
classname << com.bjrxht.enterprise.dictionary.EducationLevel.class;
classname << com.bjrxht.enterprise.dictionary.Gender.class;
classname << com.bjrxht.enterprise.dictionary.JobCategories.class;
classname << com.bjrxht.enterprise.dictionary.ListedOrNot.class;
classname << com.bjrxht.enterprise.dictionary.NumberOfEmployees.class;
classname.each{c->
    def fooDomain = new DefaultGrailsDomainClass(c )
     println "${fooDomain.propertyName}.label=${fooDomain.name}"
    fooDomain.properties.each{
        if(it.name.toString()!='id' && it.name.toString()!='version'){
            println "${fooDomain.propertyName}.${it.name}.label=${it.name.capitalize()}"
        }
        
    }
    println  ""
}

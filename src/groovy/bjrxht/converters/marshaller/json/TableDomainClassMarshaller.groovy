package bjrxht.converters.marshaller.json

import grails.converters.JSON
import org.codehaus.groovy.grails.commons.*

/*
 * Copyright 2004-2008 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import org.codehaus.groovy.grails.support.proxy.DefaultProxyHandler
import org.codehaus.groovy.grails.support.proxy.EntityProxyHandler
import org.codehaus.groovy.grails.support.proxy.ProxyHandler
import org.codehaus.groovy.grails.web.converters.exceptions.ConverterException
import org.codehaus.groovy.grails.web.converters.marshaller.ObjectMarshaller
import org.codehaus.groovy.grails.web.json.JSONWriter
import org.springframework.beans.BeanWrapper
import org.springframework.beans.BeanWrapperImpl

//import org.codehaus.groovy.grails.web.converters.ConverterUtil;
/**
 * @author xiaopeng
 * @since 1.1
 */
public class TableDomainClassMarshaller implements ObjectMarshaller<JSON> {

    private boolean includeVersion = false;
    private ProxyHandler proxyHandler;

    private boolean ifShowHasMany=false;
    private int		showStringLength=20;
    private  GrailsApplication application;
    public TableDomainClassMarshaller(boolean includeVersion,boolean ifShowHasMany,int showStringLength) {
        this(includeVersion, new DefaultProxyHandler());
        this.ifShowHasMany=ifShowHasMany;
        this.showStringLength=showStringLength;
    }

    public TableDomainClassMarshaller(boolean includeVersion) {
        this(includeVersion, new DefaultProxyHandler());
    }

    public TableDomainClassMarshaller(boolean includeVersion, ProxyHandler proxyHandler) {
        this.includeVersion = includeVersion;
        this.proxyHandler = proxyHandler;
        this.application=ApplicationHolder.getApplication();
    }

    public boolean isIncludeVersion() {
        return includeVersion;
    }

    public void setIncludeVersion(boolean includeVersion) {
        this.includeVersion = includeVersion;
    }

    public boolean supports(Object object) {
        //return ConverterUtil.isDomainClass(object.getClass());
        if (application.getDomainClass(object.getClass().getName())){
            return true;
        }else{
            return false;
        }
    }

    @SuppressWarnings(["unchecked", "rawtypes"])
    public void marshalObject(Object value, JSON json) throws ConverterException {
        JSONWriter writer = json.getWriter();
        value = proxyHandler.unwrapIfProxy(value);
        Class<?> clazz = value.getClass();
        GrailsDomainClass domainClass = application.getDomainClass(clazz.getName());
        BeanWrapper beanWrapper = new BeanWrapperImpl(value);

        writer.object();
        writer.key("class").value(domainClass.getClazz().getName());

        GrailsDomainClassProperty id = domainClass.getIdentifier();
        Object idValue = extractValue(value, id);

        json.property("id", idValue);

        if (isIncludeVersion()) {
            GrailsDomainClassProperty versionProperty = domainClass.getVersion();
            Object version = extractValue(value, versionProperty);
            json.property("version", version);
        }

        GrailsDomainClassProperty[] properties = domainClass.getPersistentProperties();

        for (GrailsDomainClassProperty property : properties) {
            if(property.getType()==([] as Byte[]).class || property.getType()==([] as byte[]).class){
                //writer.key("${property.name}");
            }else{
                if(property.isAssociation()){
                    writer.key("isAssociation-"+property.getName());
                    if((property.oneToMany || property.manyToMany)){
                    }else{
                    }

                }else{
                    writer.key(property.getName());
                }
            }
            if (!property.isAssociation()) {
                // Write non-relation property
                Object val = beanWrapper.getPropertyValue(property.getName());
                if(property.getType()==([] as Byte[]).class || property.getType()==([] as byte[]).class){
                    //if(val){
                    //writer.value("${property.name}");
                    //}else{
                    //writer.value(null);
                    //}
                    //writer.value("Blob or Clob Data");
                    //}else if(property.getType()==(new Date()).class || property.getType()==(new Time(new Date().time)).class || property.getType()==(new Timestamp(new Date().time)).class){
                }else if(property.type == Date.class || property.type == java.sql.Date.class || property.type == java.sql.Time.class || property.type == java.sql.Timestamp.class || property.type == Calendar.class){
                    if(property.type == Date.class || property.type == java.sql.Date.class || property.type == Calendar.class){
                        writer.value(val?.format('yyyy-MM-dd')?:'');
                        //be Care for Calendar calendar.time=Date
                    }
                    if(property.type == java.sql.Time.class || property.type == java.sql.Timestamp.class){
                        writer.value(val?.format('yyyy-MM-dd hh:mm:ss')?:'');
                    }
                }else if (property.type == Boolean.class || property.type == boolean.class){
                    writer.value("${val}");
                }else{
                    String valStr=val?.toString()?:'';
                    json.convertAnother(valStr);
                }

            }
            else {
                Object referenceObject = beanWrapper.getPropertyValue(property.getName());
                if (isRenderDomainClassRelations()) {
                    if (referenceObject == null) {
                        writer.value(null);
                    }
                    else {
                        referenceObject = proxyHandler.unwrapIfProxy(referenceObject);
                        if (referenceObject instanceof SortedMap) {
                            referenceObject = new TreeMap((SortedMap) referenceObject);
                        }
                        else if (referenceObject instanceof SortedSet) {
                            referenceObject = new TreeSet((SortedSet) referenceObject);
                        }
                        else if (referenceObject instanceof Set) {
                            referenceObject = new HashSet((Set) referenceObject);
                        }
                        else if (referenceObject instanceof Map) {
                            referenceObject = new HashMap((Map) referenceObject);
                        }
                        else if (referenceObject instanceof Collection){
                            referenceObject = new ArrayList((Collection) referenceObject);
                        }
                        if(this.ifShowHasMany){
                            json.convertAnother(referenceObject);
                        }else{
                            writer.value(referenceObject?.toString());
                        }

                    }
                }
                else {
                    if (referenceObject == null) {
                        json.value(null);
                    }
                    else {
                        GrailsDomainClass referencedDomainClass = property.getReferencedDomainClass();

                        // Embedded are now always fully rendered
                        if(referencedDomainClass == null || property.isEmbedded() || GrailsClassUtils.isJdk5Enum(property.getType())) {
                            json.convertAnother(referenceObject);
                        }
                        else if (property.isOneToOne() || property.isManyToOne() || property.isEmbedded()) {
                            //asShortObject(referenceObject, json, referencedDomainClass.getIdentifier(), referencedDomainClass);
                            writer.value(referenceObject?.toString());
                            asShortObject4Domain(property,referenceObject, writer,json, referencedDomainClass.getIdentifier(), referencedDomainClass);
                        }
                        else {
                            GrailsDomainClassProperty referencedIdProperty = referencedDomainClass.getIdentifier();
                            @SuppressWarnings("unused")
                            String refPropertyName = referencedDomainClass.getPropertyName();
                            if (referenceObject instanceof Collection) {
                                Collection o = (Collection) referenceObject;
                                if(this.ifShowHasMany){
                                    writer.array();
                                    for (Object el : o) {
                                        asShortObject(el, json, referencedIdProperty, referencedDomainClass);
                                    }
                                    writer.endArray();
                                }else{
                                    writer.value(referenceObject?.toString());
                                }
                                writer.key("checkbox_${property.getName()}");
                                writer.append(o.collect{
                                    if(it.id.class==java.lang.String){
                                        return "\"${it.id}\""
                                    }else{
                                        return "${it.id}"
                                    }
                                }.toString());

                            }
                            else if (referenceObject instanceof Map) {
                                Map<Object, Object> map = (Map<Object, Object>) referenceObject;
                                if(this.ifShowHasMany){
                                    for (Map.Entry<Object, Object> entry : map.entrySet()) {
                                        String key = String.valueOf(entry.getKey());
                                        Object o = entry.getValue();
                                        writer.object();
                                        writer.key(key);
                                        asShortObject(o, json, referencedIdProperty, referencedDomainClass);
                                        writer.endObject();
                                    }
                                }else{
                                    writer.value(referenceObject?.toString());
                                }
                            }
                        }
                    }
                }
            }
        }
        writer.endObject();
    }

    protected void asShortObject(Object refObj, JSON json, GrailsDomainClassProperty idProperty, GrailsDomainClass referencedDomainClass) throws ConverterException {

        Object idValue;

        if(proxyHandler instanceof EntityProxyHandler) {
            idValue = ((EntityProxyHandler) proxyHandler).getProxyIdentifier(refObj);
            if(idValue == null) {
                idValue = extractValue(refObj, idProperty);
            }

        }
        else {
            idValue = extractValue(refObj, idProperty);
        }
        JSONWriter writer = json.getWriter();
        writer.object();
        writer.key("class").value(referencedDomainClass.getName());
        String valStr=refObj?.toString();
        if(valStr?.size()>this.showStringLength){
            valStr=valStr[0..(valStr.size()-1)]+"......"
        }
        writer.key("text").value(valStr?.encodeAsHTML());
        writer.key("id").value(idValue);
        writer.endObject();
    }
    protected void asShortObject4Domain(GrailsDomainClassProperty property,Object refObj,JSONWriter writer,JSON json, GrailsDomainClassProperty idProperty, GrailsDomainClass referencedDomainClass) throws ConverterException {

        Object idValue;

        if(proxyHandler instanceof EntityProxyHandler) {
            idValue = ((EntityProxyHandler) proxyHandler).getProxyIdentifier(refObj);
            if(idValue == null) {
                idValue = extractValue(refObj, idProperty);
            }

        }
        else {
            idValue = extractValue(refObj, idProperty);
        }
        writer.key(property.getName()+".id").value(idValue);
        String valStr=refObj?.toString();
        if(valStr?.size()>this.showStringLength){
            //valStr=valStr[0..(valStr.size()-1)]+"......"
        }
        writer.key(property.getName()+".text").value(valStr?.encodeAsHTML());

    }
    protected Object extractValue(Object domainObject, GrailsDomainClassProperty property) {
        BeanWrapper beanWrapper = new BeanWrapperImpl(domainObject);
        return beanWrapper.getPropertyValue(property.getName());
    }

    protected boolean isRenderDomainClassRelations() {
        return false;
    }
}

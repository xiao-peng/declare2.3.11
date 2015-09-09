package com.bjrxht.cache

import grails.plugin.cache.web.filter.WebKeyGenerator
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUser
import org.codehaus.groovy.grails.web.util.WebUtils
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.util.StringUtils
import org.springframework.web.context.request.RequestContextHolder

import javax.servlet.http.HttpServletRequest

/* Copyright 2013 SpringSource.
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

/**
 * Generate better cache key, compare to {@link org.springframework.cache.interceptor.DefaultKeyGenerator}
 */
/**
 * Created by xp on 2015/8/12.
 */
public class SpringSecurityKeyGenerator  implements WebKeyGenerator {

    protected boolean supportAjax = false;

    public static final String X_REQUESTED_WITH = "X-Requested-With";

    public String generate(HttpServletRequest request) {

        String uri = WebUtils.getForwardURI(request);

        StringBuilder key = new StringBuilder();
        def principal=SecurityContextHolder.context?.authentication?.principal
        if(principal instanceof String){
            key.append(principal.toString());
        }
        if(principal instanceof GrailsUser){
            key.append(principal.username.toString());
        }
        key.append(":");
        key.append(org.springframework.web.servlet.support.RequestContextUtils.getLocale(request).toString());
        key.append(":");
        key.append(request.getMethod().toUpperCase());

        String format = WebUtils.getFormatFromURI(uri);
        if (StringUtils.hasLength(format) && !"all".equals(format)) {
            key.append(":format:").append(format);
        }
        if (supportAjax) {
            String requestedWith = request.getHeader(X_REQUESTED_WITH);
            if (StringUtils.hasLength(requestedWith)) {
                key.append(':').append(X_REQUESTED_WITH).append(':').append(requestedWith);
            }
        }
        key.append(':')
        def params=RequestContextHolder.currentRequestAttributes().params;
        if(params.controller && params.controller!=null && params.controller!='null'){
            key.append("/${params.controller}/${params.action}");
        }else{
            key.append(uri);
        }

        if (StringUtils.hasLength(request.getQueryString())) {
            key.append('?').append(request.getQueryString());
        }
        key.append(':')
        key.append("${params}")
        return key.toString();
    }

    public void setSupportAjax(boolean support) {
        supportAjax = support;
    }
}




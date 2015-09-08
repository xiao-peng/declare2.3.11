<g:if test="${!org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.isAjax(request)}">
	<meta name="layout" content="main"/>
</g:if>
<title><g:message code="system.login.denied.label" default="Denied" /></title>

<div class='body'>
	<div class='errors'><g:message code="system.login.denied.access.resource.label" default="Denied acess resource" />! <br/><a href="${request.contextPath}/login"><g:message code="system.login.denied.back.label" default="Back" /></a></div>
</div>

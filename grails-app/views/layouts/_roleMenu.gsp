<!-- START X-NAVIGATION -->
<ul class="x-navigation">
    <li class="xn-logo">
        <a href="${request.contextPath}/" target="_blank"><g:message code="system.logo.label" default="SRP-Sino-European Entrepreneur Connection Platform"/></a>
        <a href="#" class="x-navigation-control"></a>
    </li>
    <li class="xn-profile">
        <a href="#" class="profile-mini">
            <g:set var="str" value="${'/js/template/atlant/less/assets/images/users/no-image.jpg'}"/>
            <g:if test="${currentUser?.aviator && currentUser?.aviator?.size()>0 }">
                <g:set var="str" value="${''}"/>
            </g:if>

            <img id="aviator1" src="${request.contextPath}/workspace/userAviator" alt="<sec:username/>"/>
        </a>
        <div class="profile">
            <div class="profile-image">
                <img id="aviator2" onclick="openAviatorDialog()" src="${request.contextPath}/workspace/userAviator" alt="<sec:username/>"/>
            </div>
            <div class="profile-data">
                <div class="profile-data-name"><sec:username/></div>
                <div class="profile-data-title">
                    <g:if test="${org.springframework.web.servlet.support.RequestContextUtils.getLocale(request).toString()=='zh_CN'}">
                    ${currentUser?.authorities?.collect{it.description}?.join(',')}
                    </g:if>
                </div>
            </div>
            <div class="profile-controls">
                <a href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/workspace/profile',null)"  class="profile-control-left"><span class="fa fa-info"></span></a>
                <!--<a href="${request.contextPath}/workspace/message" class="profile-control-right"><span class="fa fa-envelope"></span></a>-->
                <a href="#" class="profile-control-right"><span class="fa fa-envelope"></span></a>
            </div>
        </div>
    </li>
    <sec:ifLoggedIn>
    <li class="active">
        <a  href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/workspace/index',null)" ><span class="fa fa-desktop"></span> <span class="xn-text"><g:message code="default.workspace.label" default="Workspace"/></span></a>
    </li>
        %{--信息管理--}%
    <li class="xn-title"><g:message code="default.infor.label" default="Infor"/></li>
    <li class="xn-openable">
        <a href="#"><span class="fa fa-clipboard"></span> <span class="xn-text"><g:message code="default.infor.label" default="Infor"/></span></a>
        <ul>
            <li><a href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/workspace/profile',null)" ><span class="fa fa-smile-o"></span><g:message code="default.person.label" default="Person"/></a></li>
            <li><a href="#" onclick="openChangePassword();"><span class="fa fa-unlock-alt"></span><g:message code="default.changePwd.label" default="ChangePwd"/></a></li>
            <!--<li><a href="${request.contextPath}/workspace/message"><span class="fa fa-heart"></span>消息管理</a></li>-->
        </ul>
    </li>
    </sec:ifLoggedIn>

%{--系统管理--}%
<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MANAGER">
    <li class="xn-title"><g:message code="default.systemSet.label" default="SystemSet"/></li>
    <li class="xn-openable">
        <a href="#"><span class="fa fa-clock-o"></span> <span class="xn-text"><g:message code="default.systemSet.label" default="SystemSet"/></span></a>
        <ul>
            <li><a href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/declare/list',null)"><span class="fa fa-clipboard"></span><g:message code="default.declare.label" default="Declare Manage"/></a></li>
            <li><a href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/apply/list',null)"><span class="fa fa-clipboard"></span><g:message code="default.apply.label" default="Apply Manage"/></a></li>
            <li><a href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/register/list',null)"><span class="fa fa-clipboard"></span><g:message code="default.register.label" default="Register Manage"/></a></li>
            <li><a href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/note/list',null)"><span class="fa fa-clipboard"></span><g:message code="default.note.label" default="Note Manage"/></a></li>
            <li><a href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/baseUser/list',null)"><span class="fa fa-user"></span><g:message code="default.allUser.label" default="AllUser"/></a></li>
            <li><a href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/baseRole/list',null)"><span class="fa fa-user"></span><g:message code="default.baseRoleSet.label" default="BaseRoleSet"/></a></li>
            <li><a href="javascript:void(0);"onclick="loadRemotePage('${request.contextPath}/requestmap/list',null)"><span class="fa fa-leaf"></span><g:message code="default.requestmapSet.label" default="RequestmapSet"/></a></li>
        </ul>
    </li>
</sec:ifAnyGranted>





<!-- END X-NAVIGATION -->
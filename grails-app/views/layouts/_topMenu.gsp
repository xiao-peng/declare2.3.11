<%@ page contentType="text/html;charset=UTF-8" %>
<!-- START X-NAVIGATION VERTICAL -->
<ul class="x-navigation x-navigation-horizontal x-navigation-panel">
    <!-- TOGGLE NAVIGATION -->
    <li class="xn-icon-button">
        <a href="#" class="x-navigation-minimize"><span class="fa fa-dedent"></span></a>
    </li>
    <!-- END TOGGLE NAVIGATION -->
    <!--
    <li class="xn-icon-button">
       <a href="#" onclick="changeToggle()"><span class="glyphicon glyphicon-fullscreen"></span></a>
    </li>
    -->
    <!-- SEARCH -->
    <!--
    <li class="xn-search">
        <form role="form">
            <input type="text" name="search" placeholder="Search..."/>
        </form>
    </li>
            -->

    <!-- END SEARCH -->
    <!-- SIGN OUT -->
    <li class="xn-icon-button pull-right">
        <a href="#" class="mb-control" data-box="#mb-signout"><span class="fa fa-sign-out"></span></a>
    </li>
    <!-- END SIGN OUT -->
    <li class="xn-icon-button pull-right">
        <a href="${request.contextPath}/workspace/index?lang=en"><span class="">English</span></a>
    </li>
    <li class="xn-icon-button pull-right">
        <a href="${request.contextPath}/workspace/index?lang=zh_CN"><span class="">中文</span></a>
    </li>
%{--    <!-- MESSAGES -->
    <g:set var="messages" value="${com.bjrxht.cms.content.Message.findAllByIsreadAndReceiver(false,currentUser,['sort':'id','order':'desc'])}" />
    <li class="xn-icon-button pull-right">
        <a href="#"><span class="fa fa-comments"></span></a>
        <div class="informer informer-danger">${messages.size()}</div>
        <div class="panel panel-primary animated zoomIn xn-drop-left xn-panel-dragging">
            <div class="panel-heading">
                <h3 class="panel-title"><span class="fa fa-comments"></span> 消息</h3>
                <div class="pull-right">
                    <span class="label label-danger"><p>${messages.size()}</p> 条新消息</span>
                </div>
            </div>
            <div class="panel-body list-group list-group-contacts scroll" id="messageListDiv" style="height: 200px;">
                <g:each in="${messages}" var="message" status="i">
                <a href="#" onclick="loadMessageByUsername(this)" class="list-group-item">
                    <div class="list-group-status status-online"></div>
                    <img src="${request.contextPath}/workspace/userAviator?username=${message.sender.username}" class="pull-left" alt="${message.sender.username}"/>
                    <span class="contacts-title">${message.sender}</span>
                    <p>${message.content}</p>
                </a>
                </g:each>
                <g:if test="${messages.size()==0}">
                    <a href="#" onclick="loadMessageByUsername(this)"  class="list-group-item">
                        <div class="list-group-status status-online"></div>
                        <img src="${request.contextPath}/workspace/userAviator" class="pull-left" alt=""/>
                        <span class="contacts-title"></span>
                        <p></p>
                    </a>
                </g:if>
            </div>
            <div class="panel-footer text-center">
                <a href="${request.contextPath}/workspace/message">显示全部消息</a>
            </div>
        </div>
    </li>
    <!-- END MESSAGES -->
    <!-- TASKS -->
    <g:set var="noteCount" value="${com.bjrxht.cms.content.Note.count()}" />
    <li class="xn-icon-button pull-right">
        <a href="#"><span class="fa fa-tasks"></span></a>
        <div class="informer informer-warning">${noteCount}</div>
        <div class="panel panel-primary animated zoomIn xn-drop-left xn-panel-dragging">
            <div class="panel-heading">
                <h3 class="panel-title"><span class="fa fa-tasks"></span> 系统通知</h3>
                <div class="pull-right">
                    <span class="label label-warning"><p>${noteCount}</p>条活跃</span>
                </div>
            </div>
            <div class="panel-body list-group scroll" id="noteListDiv" style="height: 200px;">
               <g:each in="${com.bjrxht.cms.content.Note.findAllByActive(true,['sort':'id','order':'desc'])}" var="note" status="i">
                   <a class="list-group-item" href="#">
                       <strong>${note.title}</strong>
                       <div><span>${note.content}</span></div>
                       <div class="progress progress-small">
                           <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">100%</div>
                       </div>
                       <small class="text-muted">${note.dateCreated.format("yyyy-M-dd")} /</small><small class="text-success"> Done</small>
                   </a>
               </g:each>
               <g:if test="${noteCount==0}">
                   <a class="list-group-item" href="#">
                       <strong></strong>
                       <div><span></span></div>
                       <div class="progress progress-small">
                           <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;">100%</div>
                       </div>
                       <small class="text-muted"> /</small><small class="text-success"> Done</small>
                   </a>
               </g:if>
            </div>
            <div class="panel-footer text-center">
                <!--<a href="tasks">显示全部通知</a>-->
            </div>
        </div>
    </li>
    <!-- END TASKS -->--}%
    <li class="xn-icon-button pull-right">
    <a href="javascript:;" onclick="openChangePassword();" alt="修改密码"><span class="fa fa-unlock-alt"></span></a>
    </li>
</ul>
<!-- END X-NAVIGATION VERTICAL -->
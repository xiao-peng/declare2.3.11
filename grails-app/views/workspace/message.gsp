<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:if test="${!org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.isAjax(request)}">
        <meta name="layout" content="main"/>
    </g:if>
    <script>
        $(function(){
            $('.list-group-item').click(function(){
                $('.list-group-contacts').children().removeClass('active');
                $(this).addClass('active');
                loadMessageByUsername(this);
            });
        });

        function sendMassageTo(){
            var obj={};
            obj.content=$('#inputMessage').val();
            var activeObj=$('.list-group-contacts').find('.active');
            obj.receiver=activeObj.find('img').attr('alt');
            if(obj.content && obj.receiver){
                $.post("${request.contextPath}/workspace/sendMessage", obj,
                        function (data, textStatus) {
                            if(data.result){
                                $('#inputMessage').val('');
                                var one=$('#messageBody').find('.item').first();
                                var oneclone=one.clone();
                                oneclone.addClass('in');
                                oneclone.find('a').html('${currentUser}');
                                var myDate = new Date();
                                oneclone.find('span').html(myDate.getFullYear()+'-'+myDate.getMonth()+'-'+myDate.getDate()+' '+myDate.getHours()+':'+myDate.getMinutes());
                                oneclone.find('p').html(obj.content);
                                $('#messageBody').append(oneclone);
                                $('#messageBody')[0].scrollTop=$('#messageBody')[0].scrollHeight;
                            }
                        }, "json");
            }

        }
    </script>
</head>

<body>
<!-- START CONTENT FRAME -->
<div class="content-frame">
    <!-- START CONTENT FRAME TOP -->
    <div class="content-frame-top">
        <div class="page-title">
            <h2><span class="fa fa-comments"></span> 短消息</h2>
        </div>
        <div class="pull-right">
            <button class="btn btn-danger"><span class="fa fa-book"></span> 联系人</button>
            <button class="btn btn-default content-frame-right-toggle"><span class="fa fa-bars"></span></button>
        </div>
    </div>
    <!-- END CONTENT FRAME TOP -->

    <!-- START CONTENT FRAME RIGHT -->
    <div class="content-frame-right">

        <div  class="list-group list-group-contacts border-bottom push-down-10">
            <g:each in="${users}" var="user" status="i">
                <g:if test="${loginUsers.contains(user.username)}">
                    <a href="#" class="list-group-item <g:if test="${user.id==conmunicationUser.id}">active</g:if>" >
                        <div class="list-group-status <g:if test="${onlineUsers.contains(user.username)}">status-online</g:if><g:else>status-away</g:else>"> </div>
                        <img src="${request.contextPath}/workspace/userAviator?username=${user.username}"  class="pull-left" alt="${user.username}">
                        <div class="contacts-title">${user}<span class="label label-danger">${counts.find{it[1]==user.id}?.getAt(0)?:0}</span></div>
                        <p>&nbsp;</p>
                    </a>
                </g:if>
            </g:each>
            <g:each in="${users}" var="user" status="i">
                <g:if test="${!loginUsers.contains(user.username)}">
                    <a href="#" class="list-group-item <g:if test="${user.id==conmunicationUser.id}">active</g:if>">
                        <div class="list-group-status status-offline"> </div>
                        <img src="${request.contextPath}/workspace/userAviator?username=${user.username}"  class="pull-left" alt="${user.username}">
                        <div class="contacts-title">${user}<span class="label label-danger">${counts.find{it[1]==user.id}?.getAt(0)?:0}</span></div>
                        <p>&nbsp;</p>
                    </a>
                </g:if>
            </g:each>
        </div>

        <div class="block">
            <h4>状态</h4>
            <div class="list-group list-group-simple">
                <a href="#" class="list-group-item"><span class="fa fa-circle text-success"></span> 在线</a>
                <a href="#" class="list-group-item"><span class="fa fa-circle text-warning"></span> 离开</a>
                <a href="#" class="list-group-item"><span class="fa fa-circle text-muted"></span> 未登录</a>
            </div>
        </div>

    </div>
    <!-- END CONTENT FRAME RIGHT -->

    <!-- START CONTENT FRAME BODY -->
    <div class="content-frame-body content-frame-body-left">

        <div class="messages messages-img" id="messageBody" style="max-height: 550px;min-width:400px;overflow: auto">
            <g:each in="${messages}" var="message" status="i">
                <div class="item <g:if test="${message.sender.id==currentUser.id}">in</g:if>">
                    <div class="image">
                        <img src="${request.contextPath}/workspace/userAviator?username=${message.sender.username}" alt="${message.sender}">
                    </div>
                    <div class="text">
                        <div class="heading">
                            <a href="#">${message.sender}</a>
                            <span class="date">${message.dateCreated.format('yyyy-MM-dd HH:mm')}</span>
                        </div>
                        <p>${message.content}</p>
                    </div>
                </div>
            </g:each>
            <g:if test="${messages.size()==0}">
                <div class="item in">
                    <div class="image">
                        <img src="${request.contextPath}/workspace/userAviator" alt="">
                    </div>
                    <div class="text">
                        <div class="heading">
                            <a href="#"></a>
                            <span class="date"></span>
                        </div>
                        <p></p>
                    </div>
                </div>
            </g:if>
        </div>

        <div class="panel panel-default push-up-10">
            <div class="panel-body panel-body-search">
                <div class="input-group">
                    <div class="input-group-btn">
                        <button class="btn btn-default"><span class="fa fa-camera"></span></button>
                        <button class="btn btn-default"><span class="fa fa-chain"></span></button>
                    </div>
                    <input type="text" onkeypress="if(event.keyCode==13){sendMassageTo();return false;}" class="form-control" id="inputMessage" placeholder="Your message..."/>
                    <div class="input-group-btn">
                        <button class="btn btn-default" onclick="sendMassageTo()">发送</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!-- END CONTENT FRAME BODY -->
</div>
<!-- END PAGE CONTENT FRAME -->
</body>
</html>
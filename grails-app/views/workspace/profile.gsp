<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:if test="${!org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.isAjax(request)}">
        <meta name="layout" content="main"/>
    </g:if>
    <script>
        $(function(){
            $('#formDiv').html("<img src='${request.contextPath}/js/template/atlant/less/img/blueimp/loading.gif'/>");
            <g:if test="${!currentUser?.type || currentUser?.type=='个人'}">
            $.post("${request.contextPath}/workspace/getPersonProfile", null,
                    function (data, textStatus) {
                        $('#formDiv').html(data);
                        //Bootstrap select
                        if($(".select").length > 0){
                            $(".select").selectpicker();

                            $(".select").on("change", function(){
                                if($(this).val() == "" || null === $(this).val()){
                                    if(!$(this).attr("multiple"))
                                        $(this).val("").find("option").removeAttr("selected").prop("selected",false);
                                }else{
                                    //$(this).find("option[value="+$(this).val()+"]").attr("selected",true);
                                }
                            });
                        }
                        //END Bootstrap select
                    }, "html");
            </g:if>
            <g:if test="${currentUser?.type=='机构'}">
            $.post("${request.contextPath}/workspace/getCompanyProfile", null,
                    function (data, textStatus) {
                        $('#formDiv').html(data);
                        //Bootstrap select
                        if($(".select").length > 0){
                            $(".select").selectpicker();

                            $(".select").on("change", function(){
                                if($(this).val() == "" || null === $(this).val()){
                                    if(!$(this).attr("multiple"))
                                        $(this).val("").find("option").removeAttr("selected").prop("selected",false);
                                }else{
                                    //$(this).find("option[value="+$(this).val()+"]").attr("selected",true);
                                }
                            });
                        }
                        //END Bootstrap select
                    }, "html");
            </g:if>

            $('#profileForm').form({
                success: function(data){
                    var data = eval('(' + data + ')'); // change the JSON string to javascript object
                    if (data.result){
                        $('#alertSucess').removeClass('hide');
                        setTimeout(function(){
                            $('#alertSucess').addClass('hide');
                        }, 2000);
                        if(data.changeRole){
                           $('#payButton').removeAttr('disabled');
                           window.location.reload();
                        }
                    }else{
                        $("#faultMessage").html(data.message);
                        $('#alertFault').removeClass('hide');
                    }
                }
            });
        });
        //$('#companyButton').attr('disabled',true);
        //$('#personButton').removeAttr('disabled');

        var contactAddNum=0;
        function addContact(){
            var obj=$('#allContactDiv').children().first().clone();
            obj.find('input').val('');
            var id=obj.find(".select").attr('id');
            var selectObj=obj.find(".selectParentDiv").children().first().clone();
            selectObj.attr('id','add'+contactAddNum+id);
            obj.find(".selectParentDiv").html('');
            obj.find(".selectParentDiv").append(selectObj);
            selectObj.selectpicker('val','');
            obj.appendTo($('#allContactDiv'));
            contactAddNum++;
            return false;
        }
        function remoteContact(){
            $('#allContactDiv').children().last().remove();
        }
        function updateApply(){
            $('#upgradeModal').modal('hide');
            $.post("${request.contextPath}/workspace/updateApply", null,
                    function (data, textStatus) {
                        alert("您已申请升级为付费用户，敬请期待管理员审批！");
                        $('#payButton').attr('disabled',true);
                        return false;
                    }, "json");
            return false;
        }
    </script>
</head>

<body>
<div class="modal fade panel" id="upgradeModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                &times;
                </button>
                <h4 class="modal-title" id="modalLabel">
                    用户升级
                </h4>
            </div>

            <div class="modal-body">
                <img src="${request.contextPath}/images/upgrade.jpg" />
            </div>

            <div class="modal-footer">
                <button class="btn btn-default margin" onclick="updateApply()" type="button">
                    <span class="glyphicon glyphicon-check"></span>
                    <g:message code="default.submit.label" default="Submit"/>
                </button>

            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- START BREADCRUMB -->
<ul class="breadcrumb">
    <li><a href="#">首页</a></li>
    <li><a href="#">信息管理</a></li>
    <li class="active">个人信息</li>
</ul>
<!-- END BREADCRUMB -->
<div class="row">
    <div class="col-md-3">

        <div class="panel panel-default">
            <div class="panel-body profile" style="background: url('${request.contextPath}/js/template/atlant/less/assets/images/gallery/music-4.jpg') center center no-repeat;">
                <div class="profile-image">
                    <img  src="${request.contextPath}/workspace/userAviator" alt="<sec:username/>"/>
                </div>
                <div class="profile-data">
                    <div class="profile-data-name"><sec:username/></div>
                    <div class="profile-data-title" style="color: #FFF;">${currentUser?.authorities?.collect{it.description}?.join(',')}</div>
                </div>
                <div class="profile-controls">
                    <a href="#" class="profile-control-left twitter"><span class="fa fa-weibo"></span></a>
                    <a href="#" class="profile-control-right facebook"><span class="fa fa-renren"></span></a>
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-6">
                        <button class="btn btn-info btn-rounded btn-block" onclick="openChangePassword();"><span class="fa fa-unlock"></span></button>
                    </div>
                    <div class="col-md-6">
                        <!-- onclick="document.location.href='message';" -->
                        <button class="btn btn-primary btn-rounded btn-block" > <span class="fa fa-comments"></span></button>
                    </div>
                </div>
            </div>
            <div class="panel-body list-group border-bottom">
                <a href="#info" class="list-group-item active"><span class="fa fa-bar-chart-o"></span>个人信息</a>
                <!--
                <a href="#" onclick=";$('#allInfo').animate({scrollTop:$('#info8').offset().top-50},400);" class="list-group-item"><span class="fa fa-coffee"></span> 供给项目 <span class="badge badge-default">0</span></a>
                <a href="#" class="list-group-item"><span class="fa fa-users"></span> 需求项目 <span class="badge badge-danger">+0</span></a>
                <a href="#" class="list-group-item"><span class="fa fa-folder"></span> 新闻</a>
                <a href="#" class="list-group-item"><span class="fa fa-cog"></span> 服务</a>
                -->
            </div>

        </div>

    </div>
    <form class="form-horizontal" id="profileForm" action="${request.contextPath}/workspace/saveProfile" action="saveProfile" method="post">
        <input type="hidden" name="id" value="${currentUser?.id}"/>
    <div class="col-md-9" >
        <div class="panel panel-success">
            <div class="panel-heading">
                <h3 class="panel-title">
                    个人信息
                    <sec:ifAnyGranted roles="ROLE_USER,ROLE_MEMBER">
                        <g:if test="${com.bjrxht.cms.core.BaseUserUpdate.countByApplyerAndApproverIsNull(currentUser)>0}">
                               您已申请升级为付费用户，敬请期待管理员审批！
                        </g:if>
                        <g:else>
                            <button class="btn btn-success btn-block" id="payButton"<sec:ifAnyGranted roles="ROLE_MEMBER"> disabled</sec:ifAnyGranted>   data-toggle="modal" data-target="#upgradeModal" >
                                <i class="fa fa-money"></i>升级为付费用户
                            </button>
                        </g:else>

                    </sec:ifAnyGranted>
                </h3>

            </div>
            <div class="panel-body" id="allInfo">
                <div class="alert bg-success hide" id="alertSucess" role="alert">
                    <span class="glyphicon glyphicon-check"></span>
                    <g:message code="default.sucess.label" default="Sucess"/>    <!--  data-dismiss="alert" -->
                    <a href="#" class="pull-right" onclick="$('#alertSucess').addClass('hide');"><span
                            class="glyphicon glyphicon-remove"></span></a>
                </div>

                <div class="alert bg-danger hide" id="alertFault" role="alert">
                    <span class="glyphicon glyphicon-exclamation-sign"></span>
                    <span id="faultMessage">
                        <g:message code="default.fault.label" default="Fault"/>
                    </span>

                    <a href="#" class="pull-right" onclick="$('#alertFault').addClass('hide');"><span
                            class="glyphicon glyphicon-remove"></span></a>
                </div>

                <div class="row" id="info0">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-md-3 control-label">登录邮箱</label>
                            <div class="col-md-9">
                                <div class="input-group">
                                    <span class=""><span class="fa fa-lock"></span></span>
                                    ${currentUser?.username}
                                </div>
                                <span class="help-block"><span class="required-indicator"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="col-md-3 control-label">联系电话</label>
                            <div class="col-md-9">
                                <div class="input-group">

                                    <span class="input-group-addon"><span class="fa fa-unlock"></span></span>
                                    <g:textField name="phone" required="" value="${currentUser?.phone}" class="form-control"/>
                                </div>
                                <span class="help-block"><span class="required-indicator"></span></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                       <label class="control-label"><h4>完善信息</h4></label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <button class="btn btn-info btn-block"   onclick="return false;">
                            <g:if test="${!currentUser?.type || currentUser?.type=='个人'}">
                                <i class="glyphicon glyphicon-user"></i>我是个人
                            </g:if>
                            <g:if test="${currentUser?.type=='机构'}">
                            <i class="glyphicon glyphicon-home"></i>我是机构
                            </g:if>
                        </button>

                    </div>
                </div>
                <div class="row" id="formDiv" style="padding-top: 30px">

                </div>

            </div>
            <div class="panel-footer">
                <button type="submit" class="btn btn-primary pull-right">提交</button>
            </div>
        </div>

    </div>
    </form>
</div>
</body>
</html>
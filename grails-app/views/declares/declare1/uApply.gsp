<%@ page import="com.bjrxht.declare.Register; com.bjrxht.core.BaseUser; com.bjrxht.declare.Apply" %>
<!DOCTYPE html>
<%
    def reg=Register.findByBaseUser(currentUser);
    def obj=Apply.findByDeclareAndRegister(declare,reg);
    %>
<html lang="zh_CN" class="body-full-height">
<head>
    <!-- META SECTION -->
    <title><g:message code="system.title.label" default="信息管理系统" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <!-- END META SECTION -->

    <!-- LESSCSS INCLUDE -->
    <link rel="stylesheet/less" type="text/css" href="${request.contextPath}/js/template/atlant/less/css/styles.less"/>
    <script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/lesscss/less.min.js"></script>
    <!-- EOF LESSCSS INCLUDE -->
</head>
<body>
<div class="row box animated" id="box-edit">
    <form class="form-horizontal" id="editForm" action="${request.contextPath}/apply/serverSave"
          enctype="multipart/form-data" method="post">
        <div class="panel panel-default">
            <div class="panel-body">
                <g:hiddenField name="version" value=""/>
                <g:hiddenField name="id" value="${obj?.id}"/>
                <g:hiddenField name="declare.id" value="${declare?.id}"/>
                <g:hiddenField name="register.id" value="${reg?.id}"/>
                <div class="row">
                    <%
                        def list=['单位名称','组织机构代码','法人'];
                        %>
                    <g:each in="${list}" var="field" status="i">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-md-1 control-label">${field}</label>
                                <div class="col-md-11">
                                    <div class="input-group">
                                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                        <g:textField class="form-control" name="field${i+1}" required="" value="${obj?."field${i+1}"}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>

            <div class="panel-footer">
                <button class="btn btn-default margin" type="submit"><span
                        class="glyphicon glyphicon-check"></span> &nbsp;${message(code: 'default.submit.label', default: 'Submit')}
                </button>
                <button class="btn btn-default margin  box-switcher" data-switch="box-list" type="button"><span
                        class="glyphicon glyphicon-list-alt"></span> &nbsp;${message(code: 'default.button.back.label', default: 'Back')}
                </button>
            </div>
        </div>
    </form>
</div>



</body>
</html>
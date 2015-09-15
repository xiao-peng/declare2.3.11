<%@ page import="com.bjrxht.declare.Declare;" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:if test="${!org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.isAjax(request)}">
        <meta name="layout" content="main"/>
    </g:if>
    <g:include action="js" />
    <style>
    .input-group .form-control {
        z-index: auto;
    }
    </style>
</head>

<body>
<!-- START BREADCRUMB -->
<ul class="breadcrumb">
    <li><a href="${request.contextPath}/workspace/index">首页</a></li>
    <li class="active"><g:message code="default.declare.label" default="Declare Manage"/></li>
</ul>
<!-- END BREADCRUMB -->
<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">
<!-- PAGE TITLE -->
<div class="page-title">
    <h2><span class="fa fa-arrow-circle-o-left"></span> <g:message code="default.declare.label" default="Declare Manage"/> </h2>
</div>
<!-- END PAGE TITLE -->


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

<div class="row box animated active" id="box-list">

    <div id="toolbar">


        <button class="btn btn-default margin box-switcher" onclick="newOne()" type="button" data-switch="box-edit">
            <span class="glyphicon glyphicon-plus"></span>
            新增
        </button>

        <button class="btn btn-default margin" type="button" onclick="deleteAll()">
            <span class="glyphicon glyphicon-trash"></span>
            <g:message code="default.button.delete.label" default="Delete"/>
        </button>


    </div>
    <table id="table" data-toolbar="#toolbar" data-toggle="table"
           data-url="${request.contextPath}/declare/json" data-cache="false"
           data-show-refresh="true" data-show-toggle="true" data-show-columns="true" data-search="true"
           data-side-pagination="server" data-pagination="true" data-query-params="queryParams"
           data-select-item-name="checkIds" data-sort-name="name" data-sort-order="asc">
        <thead>
        <tr>
            <th data-field="nofield" data-checkbox="true"></th>
            %{--<th data-field="id" data-sortable="true">ID</th>--}%
            <th data-field="year" data-sortable="true" >年度</th>
            <th data-field="name" data-sortable="true" >名称</th>
            <th data-field="code" data-sortable="true" >标识</th>
            <th data-field="domainName" data-sortable="true">域名</th>
            <th data-field="regBeginDate" data-sortable="true">注册开始日期</th>
            <th data-field="regEndDate" data-sortable="true">注册截止日期</th>
            <th data-field="applyBeginDate" data-sortable="true">申报起始日期</th>
            <th data-field="applyEndDate" data-sortable="true">申报截止日期</th>

            %{--<th data-field="name" data-formatter="editFormatter"><g:message code="default.button.edit.label" default="Edit"/></th>--}%

        </tr>
        </thead>
    </table>
</div>

<div class="row box animated" id="box-edit">
<form class="form-horizontal" id="editForm" action="${request.contextPath}/declare/save"
      enctype="multipart/form-data" method="post">
<div class="panel panel-default">
<div class="panel-body">
<g:hiddenField name="version" value=""/>
<g:hiddenField name="id" value=""/>

    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
            <label class="col-md-3 control-label">名称</label>
            <div class="col-md-9">
                <div class="input-group">
                    <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                    <g:textField class="form-control" name="name" required="" value=""/>
                </div>
                <span class="help-block">*</span>
            </div>
         </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="col-md-3 control-label">标识</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <g:textField class="form-control" name="code" required="" value=""/>
                    </div>
                    <span class="help-block">*</span>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="col-md-3 control-label">域名</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <g:textField class="form-control" name="domainName" required="" value=""/>
                    </div>
                    <span class="help-block">*</span>
                </div>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">注册起始日期</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <g:textField class="form-control" name="regBeginDate" required="" value=""/>
                    </div>
                    <span class="help-block">*</span>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">注册截止日期</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <g:textField class="form-control" name="regEndDate" required="" value=""/>
                    </div>
                    <span class="help-block">*</span>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">申报起始日期</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <g:textField class="form-control" name="applyBeginDate" required="" value=""/>
                    </div>
                    <span class="help-block">*</span>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label class="col-md-3 control-label">申报截止日期</label>
                <div class="col-md-9">
                    <div class="input-group">
                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                        <g:textField class="form-control" name="applyBeginDate" required="" value=""/>
                    </div>
                    <span class="help-block">*</span>
                </div>
            </div>
        </div>
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
</div>
</form>
</div>

</div>
<!-- END PAGE CONTENT WRAPPER -->

</body>
</html>
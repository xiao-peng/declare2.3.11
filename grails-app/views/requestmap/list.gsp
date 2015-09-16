<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:if test="${!org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.isAjax(request)}">
        <meta name="layout" content="main"/>
    </g:if>
    <g:include action="js" />
    <script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/daterangepicker/daterangepicker.js"></script>
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
    <li class="active"><g:message code="default.requestmapSet.label" default="RequestmapSet"/></li>
</ul>
<!-- END BREADCRUMB -->
<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">
<!-- PAGE TITLE -->
<div class="page-title">
    <h2><span class="fa fa-arrow-circle-o-left"></span><g:message code="default.requestmapSet.label" default="RequestmapSet"/></h2>
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


        %{--<button class="btn btn-default margin box-switcher" onclick="newOne()" type="button" data-switch="box-edit">--}%
            %{--<span class="glyphicon glyphicon-plus"></span>--}%
            %{--新增--}%
        %{--</button>--}%

        %{--<button class="btn btn-default margin" type="button" onclick="deleteAll()">--}%
            %{--<span class="glyphicon glyphicon-trash"></span>--}%
            %{--<g:message code="default.button.delete.label" default="Delete"/>--}%
        %{--</button>--}%


    </div>
    <table id="table" data-toolbar="#toolbar" data-toggle="table"
           data-url="${request.contextPath}/requestmap/json" data-cache="false"
           data-show-refresh="true" data-show-toggle="true" data-show-columns="true" data-search="true"
           data-side-pagination="server" data-pagination="true" data-query-params="queryParams"
           data-select-item-name="checkIds" data-sort-name="name" data-sort-order="asc">
        <thead>
        <tr>
            <th data-field="nofield" data-checkbox="true"></th>
            %{--<th data-field="id" data-sortable="true">ID</th>--}%
            <th data-field="url" data-sortable="true" >角色名称</th>
            <th data-field="configAttribute" data-sortable="true" >角色权限</th>
            %{--<th data-field="type" data-sortable="true">类型</th>--}%
        </tr>
        </thead>
    </table>
</div>

<div class="row box animated" id="box-edit">

</div>
</div>

<!-- END PAGE CONTENT WRAPPER -->

</body>
</html>
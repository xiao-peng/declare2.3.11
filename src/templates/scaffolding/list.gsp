<% import grails.persistence.Event %>

<html>
<head>
    <title></title>
    <g:if test="\${!org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.isAjax(request)}">
        <meta name="layout" content="main"/>
    </g:if>
    <g:include action="js" />
</head>

<body>
<!-- START BREADCRUMB -->
<ul class="breadcrumb">
    <li><a href="#">首页</a></li>
    <li class="active"><g:message code="${domainClass.propertyName}.label" default="${className}" /></li>
</ul>
<!-- END BREADCRUMB -->
<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">
    <!-- PAGE TITLE -->
    <div class="page-title">
        <h2><span class="fa fa-arrow-circle-o-left"></span> <g:message code="${domainClass.propertyName}.label" default="${className}" /></h2>
    </div>
    <!-- END PAGE TITLE -->


    <div class="alert bg-success hide" id="alertSucess" role="alert">
        <span class="glyphicon glyphicon-check"></span>
        <g:message code="default.sucess.label" default="Sucess"/>    <!--  data-dismiss="alert" -->
        <a href="#" class="pull-right" onclick="\$('#alertSucess').addClass('hide');"><span
                class="glyphicon glyphicon-remove"></span></a>
    </div>

    <div class="alert bg-danger hide" id="alertFault" role="alert">
        <span class="glyphicon glyphicon-exclamation-sign"></span>
        <span id="faultMessage">
            <g:message code="default.fault.label" default="Fault"/>
        </span>

        <a href="#" class="pull-right" onclick="\$('#alertFault').addClass('hide');"><span
                class="glyphicon glyphicon-remove"></span></a>
    </div>

    <div class="row box animated active" id="box-list">

        <div id="toolbar">

            <button class="btn btn-default margin box-switcher" onclick="newOne()" type="button" data-switch="box-edit">
                <span class="glyphicon glyphicon-plus"></span>
                <g:message code="default.new.label" args="['']" />
            </button>

            <button class="btn btn-default margin" type="button" onclick="deleteAll()">
                <span class="glyphicon glyphicon-trash"></span>
                <g:message code="default.button.delete.label" default="Delete"/>
            </button>

        </div>
        <table id="${domainClass.propertyName}Table" data-toolbar="#toolbar" data-toggle="table"
               data-url="\${request.contextPath}/${domainClass.propertyName}/json" data-cache="false"
               data-show-refresh="true" data-show-toggle="true" data-show-columns="true" data-search="true"
               data-side-pagination="server" data-pagination="true" data-query-params="queryParams"
               data-select-item-name="checkIds" data-sort-name="id" data-sort-order="asc">
            <thead>
            <tr>
                <th data-field="nofield" data-checkbox="true"></th>
                <%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
                allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) && (domainClass.constrainedProperties[it.name] ? domainClass.constrainedProperties[it.name].display : true) }
                Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                props.eachWithIndex { p, i ->
                    if (i < 6) {
                        if (p.isAssociation()) { %>


                <th data-field="${p.name}" <%if (p.name=='name'){%>data-formatter="nameFormatter"<%}%> >\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}</th>

                <%      } else { %>
                <th data-field="${p.name}"  data-sortable="true"  <%if (p.name=='name'){%>data-formatter="nameFormatter"<%}%> >\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}</th>
                <%  }   }   } %>
                <th data-field="id" data-formatter="editFormatter"><g:message code="default.button.edit.label" default="Edit" /></th>


            </tr>
            </thead>
        </table>
    </div>

    <div class="row box animated" id="box-edit">
        <form class="form-horizontal" id="editForm" action="\${request.contextPath}/${domainClass.propertyName}/serverSave"
              enctype="multipart/form-data" method="post">
            <div class="panel panel-default">
                <div class="panel-body">
                    <g:hiddenField name="version" value=""/>
                    <g:hiddenField name="id" value=""/>

                      <g:render template="form"/>

                    <div class="panel-footer">
                        <button class="btn btn-default margin" type="submit"><span
                                class="glyphicon glyphicon-check"></span> &nbsp;\${message(code: 'default.submit.label', default: 'Submit')}
                        </button>
                        <button class="btn btn-default margin  box-switcher" data-switch="box-list" type="button"><span
                                class="glyphicon glyphicon-list-alt"></span> &nbsp;\${message(code: 'default.button.back.label', default: 'Back')}
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
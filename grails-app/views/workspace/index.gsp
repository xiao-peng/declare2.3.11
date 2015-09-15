<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:if test="${!org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils.isAjax(request)}">
        <meta name="layout" content="main"/>
    </g:if>
<style>
.demo1::selection{color:#fff;background:#ff5e2c;}
.demo1::-moz-selection{color:#fff;background:#ff5e2c;}
.demo1::-webkit-selection{color:#fff;background:#ff5e2c;}
</style>

</head>

<body>
<!-- START BREADCRUMB -->
<ul class="breadcrumb">
    <li class="active"><a href="#">首页</a></li>
</ul>
<!-- END BREADCRUMB -->
<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">
<!-- PAGE TITLE -->
<div class="page-title">
    <h2 class="demo1"><span class="fa fa-arrow-circle-o-left"></span>工作台 </h2>
</div>


<sec:ifAnyGranted roles="ROLE_MEMBER,ROLE_USER,ROLE_PAYMENT,ROLE_PAYMENT_AGENCY">

<div class="row">
    <div class="col-md-3">
        <a href="#" class="tile tile-default">
            ${1}
            <p>待办数量</p>
            <div class="informer informer-primary">${new Date().format('yyyy-MM-dd')}</div>
            <div class="informer informer-success dir-tr"><span class="fa fa-caret-up"></span></div>
        </a>
    </div>
    <div class="col-md-3">
        <a href="#" class="tile tile-default">
            ${2}
            <p>已发需求</p>
            <div class="informer informer-primary">${new Date().format('yyyy-MM-dd')}</div>
            <div class="informer informer-success dir-tr"><span class="fa fa-caret-up"></span></div>
        </a>
    </div>
    <div class="col-md-3">
        <a href="#" class="tile tile-default">
            ${3}
            <p>已发项目</p>
            <div class="informer informer-primary">${new Date().format('yyyy-MM-dd')}</div>
            <div class="informer informer-success dir-tr"><span class="fa fa-caret-up"></span></div>
        </a>
    </div>
    <div class="col-md-3">
        <div class="widget widget-danger widget-padding-sm">
            <div class="widget-big-int plugin-clock">00:00</div>
            <div class="widget-subtitle plugin-date">Loading...</div>
            <div class="widget-controls">
                <a href="#" class="widget-control-right"><span class="fa fa-times"></span></a>
            </div>
            <div class="widget-buttons widget-c3">
                <div class="col">
                    <a href="#"><span class="fa fa-clock-o"></span></a>
                </div>
                <div class="col">
                    <a href="#"><span class="fa fa-bell"></span></a>
                </div>
                <div class="col">
                    <a href="#"><span class="fa fa-calendar"></span></a>
                </div>
            </div>
        </div>
    </div>
</div>

    <div class = "row">
        <div class="col-md-6">





            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">项目按行业分布数</h3>
                </div>
                <div class="panel-body">
                    <div id="chart-10" style="height: 300px;"><svg></svg></div>
                </div>

            </div>

            <!-- END DOUNT CHART -->

        </div>
        <div class="col-md-6">

            <!-- START DOUNT CHART -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">需求按行业分布数</h3>
                </div>
                <div class="panel-body">
                    <div id="chart-11" style="height: 300px;"><svg></svg></div>


                </div>

            </div>
            <!-- END DOUNT CHART -->

        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <div class="widget widget-primary widget-item-icon">
                <div class="widget-item-left">
                    <span class="fa fa-user"></span>
                </div>
                <div class="widget-data">
                    <div class="widget-int num-count">0</div>
                    <div class="widget-title">我的订阅</div>

                </div>
                <div class="widget-controls">
                    <a href="#" class="widget-control-right"><span class="fa fa-times"></span></a>

                    <!-- END DONUT CHART -->

                </div>
            </div>

        </div>


        <div class="col-md-6">

            <!-- START DOUNT CHART -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">各版块信息数</h3>
                </div>
                <div class="panel-body">
                    <div id="chart-12" style="height: 300px;"><svg></svg></div>


                </div>

            </div>
            <!-- END DOUNT CHART -->

        </div>







    </div>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/nvd3/lib/d3.v3.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/nvd3/nv.d3.min.js"></script>
<script>
    $(function(){
        var myColors = ["#33414E","#8DCA35","#00BFDD","#FF702A","#DA3610",
            "#80CDC2","#A6D969","#D9EF8B","#FFFF99","#F7EC37","#F46D43",
            "#E08215","#D73026","#A12235","#8C510A","#14514B","#4D9220",
            "#542688", "#4575B4", "#74ACD1", "#B8E1DE", "#FEE0B6","#FDB863",
            "#C51B7D","#DE77AE","#EDD3F2"];
        d3.scale.myColors = function() {
            return d3.scale.ordinal().range(myColors);
        };

        $.post("${request.contextPath}/workspace/indexMemberDataJson", null,
                function (data, textStatus) {
                    nv.addGraph(function() {
                        var chart = nv.models.pieChart().x(function(d) {
                            return d.label;
                        }).y(function(d) {
                            return d.value;
                        }).showLabels(true)//Display pie labels
                                .labelThreshold(.05)//Configure the minimum slice size for labels to show up
                                .labelType("percent")//Configure what type of data to show in the label. Can be "key", "value" or "percent"
                                .donut(true)//Turn on Donut mode. Makes pie chart look tasty!
                                .donutRatio(0.35)//Configure how big you want the donut hole size to be.
                                .color(d3.scale.myColors().range());;

                        d3.select("#chart-10 svg").datum(data.data10).transition().duration(350).call(chart);

                        return chart;
                    });

                    nv.addGraph(function() {
                        var chart = nv.models.pieChart().x(function(d) {
                            return d.label;
                        }).y(function(d) {
                            return d.value;
                        }).showLabels(true)//Display pie labels
                                .labelThreshold(.05)//Configure the minimum slice size for labels to show up
                                .labelType("percent")//Configure what type of data to show in the label. Can be "key", "value" or "percent"
                                .donut(true)//Turn on Donut mode. Makes pie chart look tasty!
                                .donutRatio(0.35)//Configure how big you want the donut hole size to be.
                                .color(d3.scale.myColors().range());;

                        d3.select("#chart-11 svg").datum(data.data11).transition().duration(350).call(chart);

                        return chart;
                    });
                    nv.addGraph(function() {
                        var chart = nv.models.pieChart().x(function(d) {
                            return d.label;
                        }).y(function(d) {
                            return d.value;
                        }).showLabels(true)//Display pie labels
                                .labelThreshold(.05)//Configure the minimum slice size for labels to show up
                                .labelType("percent")//Configure what type of data to show in the label. Can be "key", "value" or "percent"
                                .donut(true)//Turn on Donut mode. Makes pie chart look tasty!
                                .donutRatio(0.35)//Configure how big you want the donut hole size to be.
                                .color(d3.scale.myColors().range());;

                        d3.select("#chart-12 svg").datum(data.data12).transition().duration(350).call(chart);

                        return chart;
                    });
                }, "json");
    });


</script>
</sec:ifAnyGranted>

<sec:ifAnyGranted roles="ROLE_MANAGER">

    <div class="row">

        <div class="col-md-4">

            <a href="#" class="tile tile-primary">
                ${com.bjrxht.cms.core.BaseUserUpdate.countByApprovalIsNull()}
                <p>付费申请</p>
                <div class="informer informer-warning"><span class="fa fa-caret-down"></span></div>
                <div class="informer informer-default dir-tr">${new Date().format('yyyy-MM-dd')}</div>
            </a>
        </div>
        <div class="col-md-4">

            <a href="#" class="tile tile-primary">
               <%
                 def list= com.bjrxht.cms.core.BaseUserBaseRole.createCriteria().list{
                    projections {
                        countDistinct('baseUser')
                    }
                    'in'('baseRole',['ROLE_MEMBER','ROLE_USER','ROLE_PAYMENT','ROLE_PAYMENT_AGENCY'].collect {BaseRole.findByName(it)})
                }
               %>
                ${list[0]}
                <p>会员数</p>
                <div class="informer informer-warning"><span class="fa fa-caret-down"></span></div>
                <div class="informer informer-default dir-tr">${new Date().format('yyyy-MM-dd')}</div>
            </a>
        </div>



        <div class="col-md-4">

            <div class="widget widget-danger widget-padding-sm">
                <div class="widget-big-int plugin-clock">00:00</div>
                <div class="widget-subtitle plugin-date">Loading...</div>
                <div class="widget-controls">
                    <a href="#" class="widget-control-right"><span class="fa fa-times"></span></a>
                </div>
                <div class="widget-buttons widget-c3">
                    <div class="col">
                        <a href="#"><span class="fa fa-clock-o"></span></a>
                    </div>
                    <div class="col">
                        <a href="#"><span class="fa fa-bell"></span></a>
                    </div>
                    <div class="col">
                        <a href="#"><span class="fa fa-calendar"></span></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">

            <!-- START DOUNT CHART -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">会员类统计</h3>
                </div>
                <div class="panel-body">
                    <div id="chart-13" style="height: 300px;"><svg></svg></div>


                </div>

            </div>
            <!-- END DOUNT CHART -->

        </div>
        <div class="col-md-6">

            <!-- START DOUNT CHART -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">近半年到期会员比例</h3>
                </div>
                <div class="panel-body">
                    <div id="chart-14" style="height: 300px;"><svg></svg></div>


                </div>

            </div>
            <!-- END DOUNT CHART -->

        </div>
    </div>

    <div class="row">
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="panel-title-box">
                    <h3>一个月内到期会员列表</h3>
                    <span>Projects activity</span>
                </div>
                <ul class="panel-controls" style="margin-top: 2px;">
                    <li><a href="#" class="panel-fullscreen"><span class="fa fa-expand"></span></a></li>
                    <li><a href="#" class="panel-refresh"><span class="fa fa-refresh"></span></a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="fa fa-cog"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span> Collapse</a></li>
                            <li><a href="#" class="panel-remove"><span class="fa fa-times"></span> Remove</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="panel-body panel-body-table">

                <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                        <thead>
                        <tr>
                            <th width="50%">Project</th>
                            <th width="20%">Status</th>
                            <th width="30%">Activity</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><strong>Atlant</strong></td>
                            <td><span class="label label-danger">Developing</span></td>
                            <td>
                                <div class="progress progress-small progress-striped active">
                                    <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 85%;">85%</div>
                                </div>
                            </td>
                        </tr>


                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>

<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/nvd3/lib/d3.v3.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/nvd3/nv.d3.min.js"></script>

<script>
    $(function(){
        var myColors = ["#33414E","#8DCA35","#00BFDD","#FF702A","#DA3610",
            "#80CDC2","#A6D969","#D9EF8B","#FFFF99","#F7EC37","#F46D43",
            "#E08215","#D73026","#A12235","#8C510A","#14514B","#4D9220",
            "#542688", "#4575B4", "#74ACD1", "#B8E1DE", "#FEE0B6","#FDB863",
            "#C51B7D","#DE77AE","#EDD3F2"];
        d3.scale.myColors = function() {
            return d3.scale.ordinal().range(myColors);
        };

        $.post("${request.contextPath}/workspace/indexManageDataJson", null,
                function (data, textStatus) {
                    nv.addGraph(function() {
                        var chart = nv.models.pieChart().x(function(d) {
                            return d.label;
                        }).y(function(d) {
                            return d.value;
                        }).showLabels(true)//Display pie labels
                                .labelThreshold(.05)//Configure the minimum slice size for labels to show up
                                .labelType("percent")//Configure what type of data to show in the label. Can be "key", "value" or "percent"
                                .donut(true)//Turn on Donut mode. Makes pie chart look tasty!
                                .donutRatio(0.35)//Configure how big you want the donut hole size to be.
                                .color(d3.scale.myColors().range());;

                        d3.select("#chart-13 svg").datum(data.data13).transition().duration(350).call(chart);

                        return chart;
                    });

                    nv.addGraph(function() {
                        var chart = nv.models.pieChart().x(function(d) {
                            return d.label;
                        }).y(function(d) {
                            return d.value;
                        }).showLabels(true)//Display pie labels
                                .labelThreshold(.05)//Configure the minimum slice size for labels to show up
                                .labelType("percent")//Configure what type of data to show in the label. Can be "key", "value" or "percent"
                                .donut(true)//Turn on Donut mode. Makes pie chart look tasty!
                                .donutRatio(0.35)//Configure how big you want the donut hole size to be.
                                .color(d3.scale.myColors().range());;

                        d3.select("#chart-14 svg").datum(data.data14).transition().duration(350).call(chart);

                        return chart;
                    });
                }, "json");
    });


</script>

</sec:ifAnyGranted>

<sec:ifAnyGranted roles="ROLE_PUBLISHER,ROLE_EDITOR,ROLE_AUDITOR">

<div class="row">
    <div class="col-md-4">
        <a href="#" class="tile tile-default">
            ${News.countByStatusInList(['审核库','待发库'])}
            <p>待办数量</p>
            <div class="informer informer-primary">${new Date().format('yyyy-MM-dd')}</div>
            <div class="informer informer-success dir-tr"><span class="fa fa-caret-up"></span></div>
        </a>
    </div>
    <div class="col-md-4">
        <a href="#" class="tile tile-default">
            ${News.countByStatusInList(['发布库'])}
            <p>已发布数</p>
            <div class="informer informer-primary">${new Date().format('yyyy-MM-dd')}</div>
            <div class="informer informer-success dir-tr"><span class="fa fa-caret-up"></span></div>
        </a>
    </div>
    <div class="col-md-4">
        <div class="widget widget-danger widget-padding-sm">
            <div class="widget-big-int plugin-clock">00:00</div>
            <div class="widget-subtitle plugin-date">Loading...</div>
            <div class="widget-controls">
                <a href="#" class="widget-control-right"><span class="fa fa-times"></span></a>
            </div>
            <div class="widget-buttons widget-c3">
                <div class="col">
                    <a href="#"><span class="fa fa-clock-o"></span></a>
                </div>
                <div class="col">
                    <a href="#"><span class="fa fa-bell"></span></a>
                </div>
                <div class="col">
                    <a href="#"><span class="fa fa-calendar"></span></a>
                </div>
            </div>
        </div>

    </div>
</div>

<div class = "row">
    <div class="col-md-6">

        <!-- START BAR CHART -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">各板块信息</h3>
            </div>
            <div class="panel-body">
                <div id="chart-02" style="height: 300px;"><svg></svg></div>
            </div>
        </div>
        <!-- END BAR CHART -->

    </div>
    <div class="col-md-6">

        <!-- START DONUT CHART -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">发布情况</h3>
            </div>
            <div class="panel-body">
                <div id="chart-01" style="height: 300px;"><svg></svg></div>
            </div>
        </div>
        <!-- END DONUT CHART -->

    </div>
</div>

<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/nvd3/lib/d3.v3.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/nvd3/nv.d3.min.js"></script>
<script>
    $(function() {
        var myColors = ["#33414E", "#8DCA35", "#00BFDD", "#FF702A", "#DA3610",
            "#80CDC2", "#A6D969", "#D9EF8B", "#FFFF99", "#F7EC37", "#F46D43",
            "#E08215", "#D73026", "#A12235", "#8C510A", "#14514B", "#4D9220",
            "#542688", "#4575B4", "#74ACD1", "#B8E1DE", "#FEE0B6", "#FDB863",
            "#C51B7D", "#DE77AE", "#EDD3F2"];
        d3.scale.myColors = function () {
            return d3.scale.ordinal().range(myColors);
        };

        $.post("${request.contextPath}/workspace/indexPublisherDataJson", null,
                function (data, textStatus) {
                    nv.addGraph(function () {
                        var chart = nv.models.pieChart().x(function (d) {
                            return d.label;
                        }).y(function (d) {
                            return d.value;
                        }).showLabels(true)//Display pie labels
                                .labelThreshold(.05)//Configure the minimum slice size for labels to show up
                                .labelType("percent")//Configure what type of data to show in the label. Can be "key", "value" or "percent"
                                .donut(true)//Turn on Donut mode. Makes pie chart look tasty!
                                .donutRatio(0.35)//Configure how big you want the donut hole size to be.
                                .color(d3.scale.myColors().range());
                        ;
                        d3.select("#chart-01 svg").datum(data.data1).transition().duration(350).call(chart);

                        Morris.Bar({
                            element: 'chart-02',
                            data: data.data02,
                            xkey: 'label',
                            ykeys: ['value'],
                            labels: ['发布数'],
                            barColors: ['#B64645']
                        });

                        return chart;
                    }, "json");


        }, "json");


    });


</script>

</sec:ifAnyGranted>

<sec:ifAnyGranted roles="ROLE_PROJECT_AUDITOR,ROLE_ALL_PUSH,ROLE_PUSH,">

<div class="row">
    <div class="col-md-3">
        <a href="#" class="tile tile-default">
            ${Project.countByStatusInList(['审核中','维护中'])}
            <p>待办数量</p>
            <div class="informer informer-primary">${new Date().format('yyyy-MM-dd')}</div>
            <div class="informer informer-success dir-tr"><span class="fa fa-caret-up"></span></div>
        </a>
    </div>
    <div class="col-md-3">
        <a href="#" class="tile tile-default">
            ${Project.countByTypeAndStatus('需求','发布中')}
            <p>已发需求</p>
            <div class="informer informer-primary">${new Date().format('yyyy-MM-dd')}</div>
            <div class="informer informer-success dir-tr"><span class="fa fa-caret-up"></span></div>
        </a>
    </div>
    <div class="col-md-3">
        <a href="#" class="tile tile-default">
            ${Project.countByTypeAndStatus('项目','发布中')}
            <p>已发项目</p>
            <div class="informer informer-primary">${new Date().format('yyyy-MM-dd')}</div>
            <div class="informer informer-success dir-tr"><span class="fa fa-caret-up"></span></div>
        </a>
    </div>
    <div class="col-md-3">
        <div class="widget widget-danger widget-padding-sm">
            <div class="widget-big-int plugin-clock">00:00</div>
            <div class="widget-subtitle plugin-date">Loading...</div>
            <div class="widget-controls">
                <a href="#" class="widget-control-right"><span class="fa fa-times"></span></a>
            </div>
            <div class="widget-buttons widget-c3">
                <div class="col">
                    <a href="#"><span class="fa fa-clock-o"></span></a>
                </div>
                <div class="col">
                    <a href="#"><span class="fa fa-bell"></span></a>
                </div>
                <div class="col">
                    <a href="#"><span class="fa fa-calendar"></span></a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class = "row">
    <div class = "col-md-6">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">项目按行业分布数</h3>

            </div>
            <div class="panel-body">
                <div id="chart-9" style="height: 300px;"><svg></svg></div>
            </div>
        </div>
    </div>
    <div class = "col-md-6">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">需求按行业分布数</h3>

            </div>
            <div class="panel-body">
                <div id="chart-9-1" style="height: 300px;"><svg></svg></div>
            </div>
        </div>
    </div>

</div>

<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/nvd3/lib/d3.v3.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/nvd3/nv.d3.min.js"></script>

<script>
    $(function(){
        var myColors = ["#33414E","#8DCA35","#00BFDD","#FF702A","#DA3610",
            "#80CDC2","#A6D969","#D9EF8B","#FFFF99","#F7EC37","#F46D43",
            "#E08215","#D73026","#A12235","#8C510A","#14514B","#4D9220",
            "#542688", "#4575B4", "#74ACD1", "#B8E1DE", "#FEE0B6","#FDB863",
            "#C51B7D","#DE77AE","#EDD3F2"];
        d3.scale.myColors = function() {
            return d3.scale.ordinal().range(myColors);
        };

        $.post("${request.contextPath}/workspace/indexAuditorDataJson", null,
                function (data, textStatus) {
                    nv.addGraph(function () {
                        var chart = nv.models.pieChart().x(function (d) {
                            return d.label;
                        }).y(function (d) {
                            return d.value;
                        }).showLabels(true).color(d3.scale.myColors().range());
                        ;
                        d3.select("#chart-9 svg").datum(data.data9).transition().duration(350).call(chart);
                        return chart;
                    });
                    nv.addGraph(function() {
                        var chart = nv.models.pieChart().x(function(d) {
                            return d.label;
                        }).y(function(d) {
                            return d.value;
                        }).showLabels(true)//Display pie labels
                                .labelThreshold(.05)//Configure the minimum slice size for labels to show up
                                .labelType("percent")//Configure what type of data to show in the label. Can be "key", "value" or "percent"
                                .donut(true)//Turn on Donut mode. Makes pie chart look tasty!
                                .donutRatio(0.35)//Configure how big you want the donut hole size to be.
                                .color(d3.scale.myColors().range());
                        ;
                        d3.select("#chart-9-1 svg").datum(data.data91).transition().duration(350).call(chart);
                        return chart;
                    });
                }, "json");
    });


</script>
</sec:ifAnyGranted>
</div>




</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<g:set var="currentUser" value="${com.bjrxht.core.BaseUser.findByUsername(sec.username())}"/>
<head>
<!-- META SECTION -->
<title>系统管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<link rel="icon" href="${request.contextPath}/js/template/atlant/favicon.ico" type="image/x-icon" />
<!-- END META SECTION -->

<!-- LESSCSS INCLUDE -->
<!--<link rel="stylesheet/less" type="text/css" href="${request.contextPath}/js/template/atlant/less/css/styles.less"/>-->
<link rel="stylesheet" type="text/css" id="theme" href="${request.contextPath}/js/template/atlant/html/css/${currentUser?.skin?:'theme-default.css'}"/>
<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/template/atlant/html/css/style.css">
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/lesscss/less.min.js"></script>
<link href="${request.contextPath}/js/bootstrap-table1.7.0/bootstrap-table.css" rel="stylesheet">

<!--流程样式 -->
<link href="${request.contextPath }/js/qtip/jquery.qtip.min.css" type="text/css" rel="stylesheet" />
<!-- EOF LESSCSS INCLUDE -->
<style>
/*页内多个界面的切换样式*/
.box {
    display: none;
    -webkit-animation-name: fadeOut;
    animation-name: fadeOut;
}
.box.active {
    display: block;
    -webkit-animation-name: fadeIn;
    animation-name: fadeIn;
}
.x-navigation > li.xn-logo > a:first-child:hover {
    background-color: #D3F9A3;
}
.x-navigation > li.xn-logo > a:first-child {
    background: #E4E3E1 url("${request.contextPath}/js/template/atlant/less/img/logo.png") no-repeat scroll center top;
}
</style>
<!-- START SCRIPTS -->
<!-- START PLUGINS -->
<!--<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/jquery/jquery.min.js"></script>-->
<script type="text/javascript" src="${request.contextPath}/js/jquery-easyui-1.4.2/jquery.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/jqueryPlus.js"></script>

<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/bootstrap/bootstrap.min.js"></script>
<!-- END PLUGINS -->
<!-- START THIS PAGE PLUGINS-->
<script type='text/javascript' src='${request.contextPath}/js/template/atlant/less/js/plugins/icheck/icheck.min.js'></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/scrolltotop/scrolltopcontrol.js"></script>

<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/morris/raphael-min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/morris/morris.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/rickshaw/d3.v3.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/rickshaw/rickshaw.min.js"></script>
<script type='text/javascript' src='${request.contextPath}/js/template/atlant/less/js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js'></script>
<script type='text/javascript' src='${request.contextPath}/js/template/atlant/less/js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js'></script>
<script type='text/javascript' src='${request.contextPath}/js/template/atlant/less/js/plugins/bootstrap/bootstrap-datepicker.js'></script>
<script src="${request.contextPath}/js/template/atlant/less/js/plugins/bootstrap/bootstrap-datepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/owl/owl.carousel.min.js"></script>

<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/moment.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/daterangepicker/daterangepicker.js"></script>

<script src="${request.contextPath}/js/bootstrap-table1.7.0/bootstrap-table.js"></script>
<script src="${request.contextPath}/js/bootstrap-table1.7.0/locale/bootstrap-table-zh-CN.js"></script>
<!--
	<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/fileinput/fileinput.min.js"></script>
	-->
<script type="text/javascript" src="${request.contextPath}/js/bootstrap-fileinput-4.2.5/js/fileinput.min.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/bootstrap-fileinput-4.2.5/js/fileinput_locale_zh.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/bootstrap/bootstrap-select.js"></script>
<script type='text/javascript' src='${request.contextPath}/js/template/atlant/less/js/plugins/validationengine/languages/jquery.validationEngine-zh_CN.js'></script>
<script type='text/javascript' src='${request.contextPath}/js/template/atlant/less/js/plugins/validationengine/jquery.validationEngine.js'></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/tagsinput/jquery.tagsinput.min.js"></script>

<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins-${org.springframework.web.servlet.support.RequestContextUtils.getLocale(request)}.js"></script>
<script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/actions.js"></script>


<!-- easyui form -->
<script src="${request.contextPath}/js/jquery-easyui-1.4.2/jquery.easyui.min.js"></script>
<script src="${request.contextPath}/js/jquery-easyui-1.4.2/jquery.easyui.mobile.js"></script>
<!--流程脚本-->
<script src="${request.contextPath}/js/qtip/jquery.qtip.pack.js" type="text/javascript"></script>
<script src="${request.contextPath}/js/html/jquery.outerhtml.js" type="text/javascript"></script>
<script src="${request.contextPath}/js/workflow.js"></script>

<!-- END THIS PAGE PLUGINS-->
<script src="${request.contextPath}/plugins/events-push-1.0.M7/js/jquery/jquery.atmosphere.js" type="text/javascript" ></script>
<script src="${request.contextPath}/plugins/events-push-1.0.M7/js/grails/grailsEvents.js" type="text/javascript" ></script>
<script src="${request.contextPath}/js/application.js" type="text/javascript" ></script>

<script>
    //流程图查看引用地址
    var ctx = "${request.getContextPath()}";

    $(function(){
        if(jQuery.browser.msie){
            if(jQuery.browser.version<9){
                alert('抱歉,本系统的最佳浏览效果不支持IE9之前的浏览器版本');
            }
        }

        $.ajaxSetup({
            //contentType:"application/x-www-form-urlencoded;charset=utf-8",
            //timeout:100,
            cache:false,
            complete:function(XMLHttpRequest, textStatus){
                if (XMLHttpRequest.status==401){
                    needAuthentication();
                }
            }
            //,
            //only for xml and html, not work on json type
            //error: function(XMLHttpRequest, textStatus, errorThrown){
            //    if (XMLHttpRequest.status==401){
            //        needAuthentication();
            //    }
            //}
        });
        //visit record
        setTimeout(function(){
            var obj={};
            obj.url=document.location.href;
            obj.referrer=document.referrer;
            if(obj.url.toString().indexOf('/web/detail/')>0){
                var array=obj.url.split("/");
                obj.id=array[array.length-1];
            }
            $.post("${request.contextPath}/web/recordVisit", obj,
                    function (data, textStatus) {
                    }, "json");
        },300);

        //Bootstrap select
        var feSelect = function(){
            if($(".select").length > 0){
                $(".select").selectpicker();

                $(".select").on("change", function(){
                    if($(this).val() == "" || null === $(this).val()){
                        if(!$(this).attr("multiple"))
                            $(this).val("").find("option").removeAttr("selected").prop("selected",false);
                    }else{
                        $(this).find("option[value="+$(this).val()+"]").attr("selected",true);
                    }
                });
            }
        }//END Bootstrap select
        feSelect();
        $('#aviatorForm').form({
            url:'${request.contextPath}/workspace/changeAviator',
            success: function(data){
                var data = eval('(' + data + ')'); // change the JSON string to javascript object
                $('#modal_aviator').modal('hide');
                if (data.result){
                    $('#aviator1').attr('src','${request.contextPath}/workspace/userAviator?'+Math.random());
                    $('#aviator2').attr('src','${request.contextPath}/workspace/userAviator?'+Math.random());
                }
            }
        });
        /*
         //init message online
         //这里使用sse协议
         var grailsEvents = new grails.Events('${request.contextPath}/', {transport: 'sse'});
         //grailsEvents.close()
         function sendMessage(){
         //grailsEvents.send('toServer', {msg: "msg from browser"}); //will send data to server topic 'saveTodo'
         }

         //接受服务器发送的消息
         grailsEvents.on('fromServer', function(data){
         playAudio('alert');
         $('.informer-warning').html(Number($('.informer-warning').html())+1);
         $('.label-warning').find('p').html(Number($('.label-warning').find('p').html())+1);
         var firstObj=$('#noteListDiv').find('.list-group-item').first();
         var obj=firstObj.clone();
         obj.find('strong').html(data.title);
         obj.find('span').html(data.content);
         obj.find('.text-muted').html(data.date+' /');
         obj.insertBefore(firstObj);
         });
         grailsEvents.on('chat-${currentUser?.id}', function(data){
         playAudio('alert');
         $('.informer-danger').html(Number($('.informer-danger').html())+1);
         $('.label-danger').find('p').html(Number($('.label-danger').find('p').html())+1);
         var firstObj=$('#messageListDiv').find('.list-group-item').first();
         var obj=firstObj.clone();
         obj.find('span').html(data.sender);
         obj.find('p').html(data.content);
         obj.find('img').attr('alt',data.senderUsername);
         obj.find('img').attr('src',"${request.contextPath}/workspace/userAviator?username="+data.senderUsername);
         obj.find('.date').html(data.date);
         obj.insertBefore(firstObj);
         var showObj=$('#messageBody');
         if(showObj && showObj.length!=0){
         var img = $('.list-group-contacts').find("img[alt='"+data.senderUsername+"']");
         img.parent().find('span').html(Number(img.parent().find('span').html())+1);
         var one=showObj.find('.item').first();
         var oneclone=one.clone();
         oneclone.removeClass('in');
         oneclone.find('a').html(data.sender);
         oneclone.find('span').html(data.date);
         oneclone.find('p').html(data.content);
         showObj.append(oneclone);
         showObj[0].scrollTop=showObj[0].scrollHeight;
         }
         });
         $(window).on('beforeunload', function(){
         grailsEvents.close();
         });
         */
    });
    function needAuthentication(){
        //var mainWin=getRootWin();
        window.location.href="${request.contextPath}/logout";
    }
    function loadMessageByUsername(obj){
        var username=$(obj).find('img').attr('alt');
        var showObj=$('#messageBody');
        if(showObj && showObj.length!=0){
            $('.list-group-contacts').children().removeClass('active');
            var img = $('.list-group-contacts').find("img[alt='"+username+"']");
            img.parent().addClass('active');
            showObj.html('');
            showObj.html("<img src='${request.contextPath}/js/template/atlant/less/img/blueimp/loading.gif'/>");
            var obj={};
            obj.username=username;
            $.post("${request.contextPath}/workspace/loadMessageByUsername", obj,
                    function (data, textStatus) {
                        showObj.html(data);
                        showObj[0].scrollTop=showObj[0].scrollHeight;
                    }, "html");

        }else{
            //@todo load mesasge page
            window.document.location.href="${request.contextPath}/workspace/message?username="+username;
        }
    }
    function loadRemotePage(url,jsUrl){
        $('#mainBodyDiv').html("<img src='${request.contextPath}/js/template/atlant/less/img/blueimp/loading.gif'/>");
        $.post(url, null,
                function (data, textStatus) {
                    $('#mainBodyDiv').html('');
                    $('#mainBodyDiv').html(data);
                    try{

                    }catch(e){

                    }

                    if (jsUrl === null){

                    }else{
                        $.getScript(jsUrl, function(){
                            //alert("Load was performed.");
                        });
                    }

                    if($(".select").length > 0){
                        $(".select").selectpicker();

                        $(".select").on("change", function(){
                            if($(this).val() == "" || null === $(this).val()){
                                if(!$(this).attr("multiple"))
                                    $(this).val("").find("option").removeAttr("selected").prop("selected",false);
                            }else{
                                $(this).find("option[value="+$(this).val()+"]").attr("selected",true);
                            }
                        });
                    }
                }, "html");
    }
    function openAviatorDialog(){
        $('#modal_aviator').modal('show');
    }
    function changePassword(){
        var obj={};
        obj.old=$('#oldPass_global').val();
        obj.new1=$('#newPass_global').val();
        obj.new2=$('#newPass2_global').val();
        if(obj.old && obj.new1 &&obj.new2){
            if(obj.new1 ==obj.new2){
                $.post("${request.contextPath}/workspace/changePassword", obj,
                        function (data, textStatus) {
                            if(data.result){
                                $('#modal_password').modal('hide');
                            }
                            alert(data.message);
                        }, "json");
            }else{
                alert('确认密码与新密码不一致');
            }
        }else{
            alert('不可为空');
        }
    }
    function openChangePassword(){
        $('#oldPass_global').val('');
        $('#newPass_global').val('');
        $('#newPass2_global').val('');
        $('#modal_password').modal('show');
    }


</script>
<style>
.input-group .form-control {
    z-index: auto;
}
</style>
<g:layoutHead/>
</head>
<body>
<div class="modal" id="modal_password" tabindex="-1" role="dialog" aria-labelledby="passModalHead" aria-hidden="true">

    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="passModalHead">
                    修改密码
                </h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="form-group">
                        <label class="col-md-2 control-label">旧密码</label>

                        <div class="col-md-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                <g:textField class="form-control" type="password" name="oldPass_global"  value=""/>
                            </div>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">新密码</label>

                        <div class="col-md-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                <g:textField class="form-control" type="password"  name="newPass_global"  value=""/>
                            </div>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">确认密码</label>

                        <div class="col-md-10">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                <g:textField class="form-control" type="password"  name="newPass2_global"  value=""/>
                            </div>
                            <span class="help-block"></span>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="changePassword()" class="btn btn-default">更改</button>
            </div>
        </div>
    </div>

</div>
<div class="modal" id="modal_aviator" tabindex="-1" role="dialog" aria-labelledby="defModalHead" aria-hidden="true">
    <form id="aviatorForm" enctype="multipart/form-data" method="post" >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="defModalHead">
                        更换头像
                    </h4>
                </div>
                <div class="modal-body">
                    图片:<input type="file" name="avaitor" class="form-control input-sm m-b-10" required=""/>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-default">更改</button>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- START PAGE CONTAINER -->
<div class="page-container">

    <!-- START PAGE SIDEBAR -->
    <div class="page-sidebar">
        <g:render template="/layouts/roleMenu" model="[currentUser:currentUser]"/>
    </div>
    <!-- END PAGE SIDEBAR -->

    <!-- PAGE CONTENT -->
    <div class="page-content">
        <g:render template="/layouts/topMenu" model="[currentUser:currentUser]"/>
        <div id="mainBodyDiv">
            <g:layoutBody/>
        </div>


    </div>
    <!-- END PAGE CONTENT -->
</div>
<!-- END PAGE CONTAINER -->

<!-- MESSAGE BOX-->
<div class="message-box animated fadeIn" data-sound="alert" id="mb-signout">
    <div class="mb-container">
        <div class="mb-middle">
            <div class="mb-title"><span class="fa fa-sign-out"></span> Log <strong>Out</strong> ?</div>
            <div class="mb-content">
                <p>确定退出系统?</p>
                <p></p>
            </div>
            <div class="mb-footer">
                <div class="pull-right">
                    <a href="${request.contextPath}/logout/index" class="btn btn-success btn-lg">是</a>
                    <button class="btn btn-default btn-lg mb-control-close">否</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END MESSAGE BOX-->

<!-- START PRELOADS -->
<audio id="audio-alert" src="${request.contextPath}/js/template/atlant/less/audio/alert.mp3" preload="auto"></audio>
<audio id="audio-fail" src="${request.contextPath}/js/template/atlant/less/audio/fail.mp3" preload="auto"></audio>
<!-- END PRELOADS -->



<!-- START TEMPLATE -->
<script type="text/javascript" >
    var site_settings = '<div class="ts-button">'
            +'<span class="fa fa-cog fa-spin"></span>'
            +'</div>'
            +'<div class="ts-body">'
            +'<div class="ts-title">布局</div>'
            +'<div class="ts-row">'
            +'<label class="check"'
            +' onclick="changeToggle()" '
            +'><input type="checkbox" class="icheckbox" '
            +' onclick="changeToggle()" '
            +' name="st_sb_toggled" value="1" <g:if test="${currentUser?.fullScreen}">checked</g:if>/> 全屏</label>'
            +'</div>'
            +'<div class="ts-title">风格</div>'
            +'<div class="ts-themes">'
            +'<a href="#" class="active" data-theme="theme-default.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/default.jpg"/></a>'
            +'<a href="#" data-theme="theme-forest.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/forest.jpg"/></a>'
            +'<a href="#" data-theme="theme-dark.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/dark.jpg"/></a>'
            +'<a href="#" data-theme="theme-night.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/night.jpg"/></a>'
            +'<a href="#" data-theme="theme-serenity.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/serenity.jpg"/></a>'

            +'<a href="#" data-theme="theme-default-head-light.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/default-head-light.jpg"/></a>'
            +'<a href="#" data-theme="theme-forest-head-light.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/forest-head-light.jpg"/></a>'
            +'<a href="#" data-theme="theme-dark-head-light.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/dark-head-light.jpg"/></a>'
            +'<a href="#" data-theme="theme-night-head-light.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/night-head-light.jpg"/></a>'
            +'<a href="#" data-theme="theme-serenity-head-light.css"><img src="${request.contextPath}/js/template/atlant/less/img/themes/serenity-head-light.jpg"/></a>'

            +'</div>'
            +'</div>';

    var settings_block = document.createElement('div');
    settings_block.className = "theme-settings";
    settings_block.innerHTML = site_settings;
    //document.body.appendChild(settings_block);
    function changeToggle(){
        $('body').toggleClass('page-container-boxed');
        var obj={};
        $.get("${request.contextPath}/workspace/changeToggle", null,
                function (data, textStatus) {
                    if (data.result) {
                    }
                }, "json");
    }
    $(document).ready(function(){
        <g:if test="${!currentUser?.fullScreen}">
        $('body').toggleClass('page-container-boxed');
        </g:if>
        /* Open/Hide Settings */
        $(".ts-button").on("click",function(){
            $(".theme-settings").toggleClass("active");
        });
        /* End open/hide settings */
        $('body').on('click touchstart', '.box-switcher', function(e){
            e.preventDefault();
            var box = $(this).attr('data-switch');
            $(this).closest('.box').toggleClass('active');
            $('#'+box).closest('.box').addClass('active');
        });

        $(".ts-themes a").click(function(){
            $(".ts-themes a").removeClass("active");
            $(this).addClass("active");
            $("#theme").attr("href","${request.contextPath}/js/template/atlant/html/css/"+$(this).data("theme"));
            var obj={};
            obj.skin=$(this).data("theme");
            $.get("${request.contextPath}/workspace/changeSkin", obj,
                    function (data, textStatus) {
                        if (data.result) {
                        }
                    }, "json");
            return false;
        });
    });
</script>




<!-- END TEMPLATE -->
<!-- END SCRIPTS -->
</body>
</html>
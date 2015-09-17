<!DOCTYPE html>
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
    <style>
    .form-group .control-label{
            color: #fff;
        }
    </style>
    <script>
        $(function(){
            var validator = $("#registerForm").validate({
                rules: {
                    email: {
                        required: true,
                        email: true
                    },
                    password: {
                        required: true,
                        minlength:8,
                        maxlength: 20
                    },
                    repassword: {
                        required: true,
                        minlength: 8,
                        maxlength: 10,
                        equalTo: "#password"
                    },
                    phone: {
                        required: true,
                        minlength:6,
                        maxlength: 20
                    }
                }
            });
            $('#registerForm').form({
                url:'${request.contextPath}/registration/registerSave',
                onSubmit:function(){
                    var valid = true;
                    $('input,textarea').each(function(i,v){
                        valid = validator.element(v) && valid;
                    });
                    if(!valid){
                        validator.focusInvalid();
                        return false;
                    }
                    return valid;
                },
                success: function(data){
                    var data = eval('(' + data + ')'); // change the JSON string to javascript object
                    if (data.result){
                        alert('<g:message code="system.register.success.tip.label" default="System register success,please active account from email" />!');
                        window.location.href=data.url;
                    }else{
                        alert(data.message);
                    }
                }
            });
            var uiElements = function(){

                // Start Smart Wizard
                var uiSmartWizard = function(){

                    if($(".wizard").length > 0){

                        //Check count of steps in each wizard
                        $(".wizard > ul").each(function(){
                            $(this).addClass("steps_"+$(this).children("li").length);
                        });//end

                        $(".wizard").smartWizard({
                            labelNext:'<g:message code="system.register.wizard.next.label" default="Next" />', // label for Next button
                            labelPrevious:'<g:message code="system.register.wizard.previous.label" default="Previous" />', // label for Previous button
                            labelFinish:'<g:message code="system.register.wizard.finish.label" default="Finish" />',  // label for Finish button
                            // This part of code can be removed FROM
                            onLeaveStep: function(obj){
                                var wizard = obj.parents(".wizard");

                                if(wizard.hasClass("wizard-validation")){
                                    var valid = true;

                                    $('input,textarea',$(obj.attr("href"))).each(function(i,v){
                                        valid = validator.element(v) && valid;
                                    });

                                    if(!valid){
                                        wizard.find(".stepContainer").removeAttr("style");
                                        validator.focusInvalid();
                                        return false;
                                    }
                                    return valid;
                                }

                                return true;
                            },// <-- TO

                            //This is important part of wizard init
                            onShowStep: function(obj){
                                var wizard = obj.parents(".wizard");

                                if(wizard.hasClass("show-submit")){

                                    var step_num = obj.attr('rel');
                                    var step_max = obj.parents(".anchor").find("li").length;

                                    if(step_num == step_max){
                                        obj.parents(".wizard").find(".actionBar .btn-primary").css("display","block");
                                    }
                                }
                                return true;
                            }//End
                        });
                    }

                }// End Smart Wizard
                return {
                    init: function(){
                        uiSmartWizard();
                    }
                }

            }();
            uiElements.init();
            /* My Custom Progressbar */
            $.mpb = function(action,options){

                var settings = $.extend({
                    state: '',
                    value: [0,0],
                    position: '',
                    speed: 20,
                    complete: null
                },options);

                if(action == 'show' || action == 'update'){

                    if(action == 'show'){
                        $(".mpb").remove();
                        var mpb = '<div class="mpb '+settings.position+'">\n\
                               <div class="mpb-progress'+(settings.state != '' ? ' mpb-'+settings.state: '')+'" style="width:'+settings.value[0]+'%;"></div>\n\
                           </div>';
                        $('body').append(mpb);
                    }

                    var i  = $.isArray(settings.value) ? settings.value[0] : $(".mpb .mpb-progress").width();
                    var to = $.isArray(settings.value) ? settings.value[1] : settings.value;

                    var timer = setInterval(function(){
                        $(".mpb .mpb-progress").css('width',i+'%'); i++;

                        if(i > to){
                            clearInterval(timer);
                            if($.isFunction(settings.complete)){
                                settings.complete.call(this);
                            }
                        }
                    }, settings.speed);

                }

                if(action == 'destroy'){
                    $(".mpb").remove();
                }

            }
            /* Eof My Custom Progressbar */
            // New selector case insensivity
            $.expr[':'].containsi = function(a, i, m) {
                return jQuery(a).text().toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
            };


        });

    </script>
</head>
<body>

<div class="login-container lightmode">
<div class="login-box animated fadeInDown" style="width: 800px">
<div class="login-body">
<div class="login-title" style="padding-top: 20px;">
    %{--<strong><g:message code="system.login.register.label" default="Register" /></strong>--}%
    %{--<p style="color: darkred;font-size: 12px">--}%
    %{--${flash.message}--}%
    %{--</p>--}%
    <div class="pull-left">
        <img src="${request.contextPath}/js/template/atlant/less/img/logo-grey.png" style="margin-left: -60px;margin-top: -20px;">
        %{--<a href="${request.contextPath}/register/index" style="color: white"><g:message code="system.login.register.label" default="Register" /></a> |--}%
        %{--<a href="${request.contextPath}/login/forgetPass" style="color: white"><g:message code="system.login.forget.password.label" default="Forget passowrd" /></a>--}%
    </div>
    <span style="float: right">
        <h3 style="color: #fff;"><g:message code="baseUserBaseRole.baseUser.label" default="User Register" />
            <g:message code="system.login.register.label" default="Register" /></h3>
        <p style="text-align: right;">
            <a href="${request.contextPath}/login?lang=zh_CN" style="color: white;font-size: 12px;">中文<!--<img src="${request.contextPath}/images/customicondesign-flags/png/32/China-flag.png" style="border: 0px;"/>--></a>
            |<a href="${request.contextPath}/login?lang=en" style="color: white;font-size: 12px;">English<!--<img src="${request.contextPath}/images/customicondesign-flags/png/32/United-kingdom-flag.png" style="border: 0px;"/>--></a>
        </p>
    </span>
</div>
<div class="block">
<form action= '${request.contextPath}/declare/registerSave' class="form-horizontal" method="post" id="registerForm">
<input name="HTMLcode" value="${params.HTMLcode}" type="hidden">
<div id="step-8">

    <div class="form-group">
        <label class="col-md-2 control-label"><g:message code="baseUser.email.label" default="Email" /></label>
        <div class="col-md-10">
            <input type="text" class="form-control" name="email" placeholder="<g:message code="baseUser.email.label" default="Email" />"/>
        </div>
    </div>
    %{--<div class="form-group">--}%
        %{--<label class="col-md-2 control-label"><g:message code="baseUser.username.label" default="Username" /></label>--}%
        %{--<div class="col-md-10">--}%
            %{--<input type="text" class="form-control" name="username" placeholder="<g:message code="baseUser.username.label" default="Username" />"/>--}%
        %{--</div>--}%
    %{--</div>--}%
    <div class="form-group">
        <label class="col-md-2 control-label"><g:message code="baseUser.firstName.label" default="FirstName" /></label>
        <div class="col-md-10">
            <input type="text" class="form-control" name="firstName" placeholder="<g:message code="baseUser.firstName.label" default="FirstName" />"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-2 control-label"><g:message code="baseUser.lastName.label" default="LastName" /></label>
        <div class="col-md-10">
            <input type="text" class="form-control" name="lastName" placeholder="<g:message code="baseUser.lastName.label" default="LastName" />"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-2 control-label"><g:message code="baseUser.password.label" default="Password" /></label>
        <div class="col-md-10">
            <input type="password" class="form-control" name="password" placeholder="<g:message code="baseUser.password.label" default="Password" />" id="password"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-2 control-label"><g:message code="system.login.forget.password.confirm.label" default="Confirm" /> <g:message code="system.login.password.label" default="Password" /></label>
        <div class="col-md-10">
            <input type="password" class="form-control" name="repassword" placeholder="<g:message code="system.login.forget.password.confirm.label" default="Confirm" /> <g:message code="system.login.password.label" default="Password" />"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-2 control-label"><g:message code="system.login.forget.password.phone.label" default="Register phone" /></label>
        <div class="col-md-10">
            <input type="text" class="form-control" name="phone" placeholder="<g:message code="system.login.forget.password.phone.label" default="Register phone" />"/>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-4"></div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-warning btn-block"><g:message code="default.submit.label" default="Submit" /></button>
        </div>
        <div class="col-md-2">
            <button type="reset" class="btn btn-warning btn-block"><g:message code="default.reset.label" default="Reset" /></button>
        </div>
        <div class="col-md-4"></div>
    </div>
</div>
</form>
</div>

</div>
<div class="login-footer">
    <div class="pull-left">
        %{--&copy; 2015 copyRight--}%
    </div>
    <div class="pull-right">
        <a href="${request.contextPath}/login/auth"><g:message code="system.login.title.label" default="System login" /></a>
        %{--<a href="${request.contextPath}/login/forgetPass"><g:message code="system.login.forget.password.label" default="Forget passowrd" /></a>--}%
    </div>
</div>
</div>

</div>


</body>
</html>
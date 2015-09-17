<!DOCTYPE html>
<html lang="zh_CN" class="body-full-height">
<head>
    <title><g:message code="system.title.label" default="信息管理系统" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet/less" type="text/css" href="${request.contextPath}/js/template/atlant/less/css/styles.less"/>
    <script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/lesscss/less.min.js"></script>
</head>
<body>

<div class="login-container lightmode">
%{--<div class="login-container lightmode" style="background: url('${request.contextPath}/js/template/atlant/less/img/backgrounds/wall_1.jpg') center no-repeat fixed;">--}%

    <div class="login-box animated fadeInDown" style="padding-top: 200px;">
        %{--<div class="login-logo" ></div>--}%
        <div class="login-body">
            <div class="login-title" style="font-size: 12px;padding-bottom: 20px">

                <!--<strong><g:message code="system.login.title.label" default="System Login" /></strong>-->
                <div class="pull-left">
                    <img src="${request.contextPath}/js/template/atlant/less/img/logo-grey.png" style="margin-left: -60px;margin-top: -20px;">
                    %{--<a href="${request.contextPath}/register/index" style="color: white"><g:message code="system.login.register.label" default="Register" /></a> |--}%
                    %{--<a href="${request.contextPath}/login/forgetPass" style="color: white"><g:message code="system.login.forget.password.label" default="Forget passowrd" /></a>--}%
                </div>
            <span style="float: right">
                <a href="${request.contextPath}/login?lang=zh_CN" style="color: white">中文<!--<img src="${request.contextPath}/images/customicondesign-flags/png/32/China-flag.png" style="border: 0px;"/>--></a>
                |<a href="${request.contextPath}/login?lang=en" style="color: white">English<!--<img src="${request.contextPath}/images/customicondesign-flags/png/32/United-kingdom-flag.png" style="border: 0px;"/>--></a>
            </span>
            <p style="color: darkred;font-size: 12px">
                ${flash.message}
                </p>
            </div>
            <form action='${postUrl}' class="form-horizontal" method='post' id='loginForm' >
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="text" name="j_username" class="form-control" placeholder="<g:message code="system.login.username.label" default="Login username" />"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="password"  name="j_password"  class="form-control" placeholder="<g:message code="system.login.password.label" default="Password" />"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-6">
                        <input type='checkbox' class='chk' name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>
                        <label for='remember_me' style="color:white"><g:message code="system.login.rememberme.label" default="Remember me" /></label>
                    </div>
                    <div class="col-md-6" style="color: #fff;text-align: right;">
                        <a href="${request.contextPath}/register.html" style="color: white"><g:message code="system.login.register.label" default="Register" /></a> |
                        <a href="${request.contextPath}/forgetPass.html" style="color: white"><g:message code="system.login.forget.password.label" default="Forget passowrd" /></a>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-6" style="color: #fff;">
                    &copy; 2015 copyRight
                    </div>
                    <div class="col-md-6">
                        <button type="submit" class="btn btn-warning btn-block"><g:message code="system.login.button.label" default="Login" /></button>
                    </div>
                </div>
            </form>
                <div class="form-group">

                </div>
                <div class="login-subtitle">

                </div>

        </div>
        <div class="login-footer">
            <div class="pull-left">

            </div>

        </div>
    </div>

</div>

</body>
</html>
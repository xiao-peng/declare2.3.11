<!DOCTYPE html>
<html lang="en" class="body-full-height">
<head>
    <!-- META SECTION -->
    <title><g:message code="system.login.title.label" default="System Login" /></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <!-- END META SECTION -->

    <!-- LESSCSS INCLUDE -->
    <link rel="stylesheet/less" type="text/css" href="${request.contextPath}/js/template/atlant/less/css/styles.less"/>
    <script type="text/javascript" src="${request.contextPath}/js/template/atlant/less/js/plugins/lesscss/less.min.js"></script>
    <!-- EOF LESSCSS INCLUDE -->
    <script >
    function forgetPass(){
        var obj={};
        obj.email=$('#email').val();
        obj.phone=$('#phone').val();
        if(obj.email && obj.phone){
            $.post("${request.contextPath}/login/resetPass", obj,
                    function (data, textStatus) {
                        alert(data.message);
                        if(data.result){
                            window.location.href=data.url;
                        }
                    }, "json");
        }else{
            alert('<g:message code="system.form.validate.blank.label" default="can't be blank" />');
        }
    }
    </script>
</head>
<body>

<div class="login-container lightmode" >
%{--<div class="login-container lightmode"  style="background: url('${request.contextPath}/js/template/atlant/less/img/backgrounds/wall_1.jpg') center no-repeat fixed;">--}%

    <div class="login-box animated fadeInDown" style="padding-top: 200px;">
        %{--<div class="login-logo"></div>--}%
        <div class="login-body">
            <div class="login-title" style="padding: 20px 0;">
                %{--<strong><g:message code="system.login.forget.password.label" default="Forget passowrd" /></strong>--}%
                <div class="pull-left">
                    <img src="${request.contextPath}/js/template/atlant/less/img/logo-grey.png" style="margin-left: -60px;margin-top: -20px;">
                    %{--<a href="${request.contextPath}/register/index" style="color: white"><g:message code="system.login.register.label" default="Register" /></a> |--}%
                    %{--<a href="${request.contextPath}/login/forgetPass" style="color: white"><g:message code="system.login.forget.password.label" default="Forget passowrd" /></a>--}%
                </div>
                <span style="float: right">
                    <h3 style="color: #fff;"><g:message code="system.login.forget.password.label" default="Forget Password"/> </h3>
                    </span>
            </div>
            <form   class="form-horizontal" method='post'  >
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="text" id="email" class="form-control" placeholder="<g:message code="system.login.forget.password.email.label" default="Register email" />"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <input type="text"  id="phone"  class="form-control" placeholder="<g:message code="system.login.forget.password.phone.label" default="Register phone" />"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-md-6" style="color: #fff;line-height: 32px;">
                        <a href="${request.contextPath}/register/index" style="color: #fff;"><g:message code="system.login.register.label" default="Register" /></a> |
                        <a href="${request.contextPath}/login/auth" style="color: #fff;"><g:message code="system.login.title.label" default="System login" /></a>
                        <br><p style="text-align: left;color: #fff;">
                        <a href="${request.contextPath}/login?lang=zh_CN" style="color: white">中文<!--<img src="${request.contextPath}/images/customicondesign-flags/png/32/China-flag.png" style="border: 0px;"/>--></a>
                        |<a href="${request.contextPath}/login?lang=en" style="color: white">English<!--<img src="${request.contextPath}/images/customicondesign-flags/png/32/United-kingdom-flag.png" style="border: 0px;"/>--></a>
                    </p>
                    </div>
                    <div class="col-md-6">
                        <button type="button" onclick="forgetPass()" class="btn btn-warning btn-block"><g:message code="system.login.forget.password.confirm.label" default="Confirm" /></button>
                        <br><p style="text-align: right;color: #fff;">&copy; 2015 copyRight</p>
                    </div>
                </div>

                <div class="form-group">

                </div>
                <div class="login-subtitle">

                </div>
            </form>
        </div>
        <div class="login-footer">
            <div class="pull-left">

            </div>
            <div class="pull-right">
               </div>
        </div>
    </div>

</div>

</body>
</html>
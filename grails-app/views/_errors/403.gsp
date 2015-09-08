<html>
	<head>
		<title>403 - Forbidden!</title>
		<meta name="layout" content="error" />
	</head>

<body>
<center>
	<content tag="header" style="height: 100px">
		403
	</content>

	<section id="Error" class="" style="height: 400px">
		<div class="big-message">
			<div class="container">
				<h1 style="height:50px">
					&nbsp;
				</h1>
				<h2>

				</h2>
				<p>
					<img src="${request.contextPath}/images/cry.png"/>
				</p>
				<h3 style='font-size: 50px;font-family: "microsoft yahei";color:#2080b9'>
					无权查看此资源
				</h3>
				<div class="actions">
					<a href="${createLink(uri: '/logout')}" class="btn btn-large btn-primary">
						<i class="icon-chevron-left icon-white"></i>
						退出系统
					</a>
				</div>
			</div>
		</div>
	</section>
</center>
  
  
  </body>
</html>
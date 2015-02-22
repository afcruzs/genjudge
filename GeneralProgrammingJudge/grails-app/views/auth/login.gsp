<!DOCTYPE html>
<html>
    <head>
        <title>General Programming Judge</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <!-- Bootstrap -->
            
            <link rel="stylesheet" type="text/css"
				href="${resource(dir:'css', file:'bootstrap.min.css')}" />

            <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
            <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
            <!--[if lt IE 9]>
              <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
              <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
            <![endif]-->
    </head>
    <body>
    	<h2>General Programming Judge</h2>
		 <div class="container">
		            <div class="jumbotron">        
		        <g:if test="${flash.message}">
				    <div class="message">${flash.message}</div>
				  </g:if>
				  <g:form action="signIn">
				    <input type="hidden" name="targetUri" value="${targetUri}" />
				    <table  class="table table-bordered table-striped">
				      <tbody>
				        <tr>
				          <td>Username:</td>
				          <td><input type="text" name="username" value="${username}" /></td>
				        </tr>
				        <tr>
				          <td>Password:</td>
				          <td><input type="password" name="password" value="" /></td>
				        </tr>
				        <tr>
				          <td>Remember me?:</td>
				          <td><g:checkBox name="rememberMe" value="${rememberMe}" /></td>
				        </tr>
				        <tr>
				          <td />
				          <td><input type="submit" value="Sign in" /></td>
				        </tr>
				      </tbody>
				    </table>
				  </g:form>
				</div>
			</div>
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://code.jquery.com/jquery.js"></script>
        
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="${resource(dir:'', file:'js/bootstrap.min.js')}"></script>
        
    </body>
</html>
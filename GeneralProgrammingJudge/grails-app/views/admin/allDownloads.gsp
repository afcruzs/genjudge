<!DOCTYPE html>
<html>
    <head>
        <title>GPJ</title>
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
            
             <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	        <script src="https://code.jquery.com/jquery.js"></script>
	        
	        <!-- Include all compiled plugins (below), or include individual files as needed -->
	        <script src="${resource(dir:'', file:'js/bootstrap.min.js')}"></script>
    </head>
    <body>
        
        
        <g:render template="/templates/header" />
        
        <h2 align="center">Users Downloads</h2>
       <table class="table table-bordered table-striped">
		 	<tbody>
	 			<tr>
	 				<td>User</td>
	 				<td>Date</td>
	 				<td>User Input</td>
	 				<td>User Output</td>
	 			</tr>
		 		<g:each in="${downloads}">
		 			
		 			<tr>
		 				<td> ${it.user.username}</td>
		 				<td>${it.downloadDate} </td>
		 				<td> <a href="downloadInput?tcId=${it.testCase.id}"> Download Input </a> </td>
		 				<td> <a href="downloadOutput?tcId=${it.testCase.id}"> Download Output </a> </td>
		 			</tr>
		        </g:each>
		 		
		 	</tbody>
		 </table>
		 
		 <h2 align="center">Users Submissions</h2>
		 <table class="table table-bordered table-striped">
		 	<tbody>
		 		<tr>
	 				<td>User</td>
	 				<td>Date</td>
	 				<td>Correct</td>
	 				<td>User output</td>
		 		</tr>
		 		<g:each in="${submissions}">
		 			<tr>
		 				<td> ${it.user.username}</td>
		 				<td> ${it.date} </td>
		 				<td> ${it.correct} </td>
		 				<td> <a href="downloadUserOutput?subId=${it.id}"> Download Output </a> </td>
		 			</tr>
		        </g:each>
		 		
		 	</tbody>
		 </table>
        
    </body>
</html>
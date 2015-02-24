<!DOCTYPE html>
<html>
    <head>
        <title>GPJ</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <!-- Bootstrap -->
            
            <link rel="stylesheet" type="text/css"
				href="${resource(dir:'css', file:'bootstrap.min.css')}" />
				<link rel="stylesheet" type="text/css"
				href="${resource(dir:'css', file:'datepicker.css')}" />

            <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
            <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
            <!--[if lt IE 9]>
              <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
              <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
            <![endif]-->
            
             <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	        <script src="https://code.jquery.com/jquery.js"></script>
	        <script src="${resource(dir:'', file:'js/moment.js')}"></script>
	        <script src="${resource(dir:'', file:'js/transition.js')}"></script>
	        <script src="${resource(dir:'', file:'js/collapse.js')}"></script>
	        <script src="${resource(dir:'', file:'js/bootstrap.min.js')}"></script>
	        <script src="${resource(dir:'', file:'js/bootstrap-datepicker.js')}"></script>
	        
	        <!-- Include all compiled plugins (below), or include individual files as needed -->
	        <script src="${resource(dir:'', file:'js/bootstrap.min.js')}"></script>
    </head>
    <body>
        
        
        <g:render template="/templates/header" />
        
        <div class="container">
        	<h2>Edit ${problem.name}</h2>
        	
            <div class="jumbotron">
               <g:uploadForm controller='Admin' action='doEditProblem'>
               		<input type="hidden" id="problemId" name="problemId" value="${problem.id}">
				    <label>Title</label>
					<input id="titleInput" name="titleInput" class="form-control" placeholder="title" value="${problem.name}">
					<br>
				    <label>Pdf description</label>
				    <input type='file' name='file'/>
				    <br>
				    <label> Input Cases </label> 
				    <input type="file" name="input" multiple>
				    <br>
				    <label> Output Cases </label> 
				    <input type="file" name="output" multiple>
				    <br>
				    <label>Time (Milliseconds) </label>
					<input  type="number"  id="time" name="time" class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' value="${problem.timeToAnswer}" >
					<br>
				    <input class="btn btn-primary btn-lg" type='submit' value="Save"/>
				</g:uploadForm>
            </div>
        </div>
        
    </body>
</html>
<!DOCTYPE html>
<html>
    <head>
        <title>GPJ-Upload Problem</title>
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
        
        
        <g:render template="/templates/header" />
        
        
        
        <div class="container">
        	<div class="jumbotron">
				<g:uploadForm controller='Admin' action='doUploadProblem'>
				    <label>Title</label>
					<input id="titleInput" name="titleInput" class="form-control" placeholder="title">
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
					<input  type="number"  id="time" name="time" class="form-control" onkeypress='return event.charCode >= 48 && event.charCode <= 57' >
					<br>
				    <input class="btn btn-primary btn-lg" type='submit' value="Save"/>
				</g:uploadForm>
        		
        		<br>
        		<a class="btn btn-primary btn-lg" href="index">Back</a>
        	</div>
        </div>
        
        
        
        
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://code.jquery.com/jquery.js"></script>
        
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="${resource(dir:'', file:'js/bootstrap.min.js')}"></script>
        
    </body>
</html>
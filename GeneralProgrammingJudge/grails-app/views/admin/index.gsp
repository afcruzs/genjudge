<!DOCTYPE html>
<html>
    <head>
        <title>Admin</title>
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
        	<h2>Problems</h2>
            <div class="jumbotron">
              	<a class="btn btn-primary btn-lg" href="uploadProblem">Upload Problem</a>
              	<a class="btn btn-primary btn-lg disabled" href="#">Delete Problem</a>
              	
            </div>
        </div>
        
        <div class="container">
        	<h2>Contest</h2>
            <div class="jumbotron">
              <a class="btn btn-primary btn-lg" href="createContest">Create Contest</a>
              <a class="btn btn-primary btn-lg disabled">Delete Contest</a>
              <a class="btn btn-primary btn-lg disabled">See Contest</a>              
            </div>
        </div>
        
        <div class="container">
        	<h2>Ranking</h2>
            <div class="jumbotron">
              <a class="btn btn-primary btn-lg disabled">Check Ranking</a>
            </div>
        </div>
        
        <script>
        </script>
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://code.jquery.com/jquery.js"></script>
        
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="${resource(dir:'', file:'js/bootstrap.min.js')}"></script>
        
    </body>
</html>
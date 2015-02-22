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
        
        
        <g:render template="/templates/header" />
        
        
        <div class="container">
            <div class="jumbotron">
              <h1>Welcome ${getCurrentUserName()}</h1>
              	<p class="lead">
              		Instructions:
              	</p>
              	<ul>
              	
				 	<li>
						<p class="lead">
					  		In the contest button you will find the available contest to participate.
						</p>
				  	</li>
				  	
				  	<li>
						<p class="lead">
					  		A problem consists of a input file and you should make the output file with 
		              	exactly the same format as is explained in the pdf description, any mistake like
		              	extra spaces and/or extra endlines will give you a wrong answer, so please be careful.
						</p>
				  	</li>
				  
				  <li>
						<p class="lead">
					  		To submit a problem read it first and start to code the solution in your machine.
              				When you are done, make sure you have enough time to download the input and run it
              				in your computer, once is downloaded a timer will start and you will have limited time
              				to upload the output produced by your program. Make sure you have an efficient program such
              				that fits the time given by the problem to upload the solution.
						</p>
				  </li>
				  
				  <li>
						<p class="lead">
					  		Be careful because there is NOT an unlimited amount of input downloads.
						</p>
				  </li>
				  
				  
				</ul>
              
            </div>
        </div>
        
        
        
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://code.jquery.com/jquery.js"></script>
        
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="${resource(dir:'', file:'js/bootstrap.min.js')}"></script>
        
    </body>
</html>
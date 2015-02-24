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
        
        <script>
			function linkToContest(){
				$("#goToContest").attr("href", "seeContest?contestId=" + $("#contestSelect  option:selected").val());
			}

			function linkToContest2(){
				$("#goToContest2").attr("href", "editContest?contestId=" + $("#contestSelect2  option:selected").val());
			}

			function linkToContest3(){
				$("#goToContest3").attr("href", "editProblem?problemId=" + $("#contestSelect3  option:selected").val());
			}
        </script>
        
        <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close</button>
		            <h3 class="modal-title" id="myModalLabel">Choose a Contest</h3>
		            </div>
		            <div class="modal-body">
		                <select class="form-control" id="contestSelect" name="contestSelect">
							<g:each var="contest" in="${contests}" >
								<option id="${'contest'+contest.id}" value="${contest.id}">${contest.name}</option>
							</g:each>
						</select>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		                <a id="goToContest"class="btn btn-default" href="#" onclick="linkToContest()">Go</a>
		                <g:if test="${contests.size() == 0}">
		                	<script>
		                		$("#goToContest").attr('disabled','disabled');
		                	</script>
		                </g:if>
		        </div>
		    </div>
		  </div>
		</div>
		
		
		<div class="modal fade" id="basicModal2" tabindex="-1" role="dialog" aria-labelledby="basicModal2" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close</button>
		            <h3 class="modal-title" id="myModalLabel">Choose a Contest</h3>
		            </div>
		            <div class="modal-body">
		                <select class="form-control" id="contestSelect2" name="contestSelect2">
							<g:each var="contest" in="${contests}" >
								<option id="${'contest'+contest.id}" value="${contest.id}">${contest.name}</option>
							</g:each>
						</select>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		                <a id="goToContest2"class="btn btn-default" href="#" onclick="linkToContest2()">Go</a>
		                <g:if test="${contests.size() == 0}">
		                	<script>
		                		$("#goToContest2").attr('disabled','disabled');
		                	</script>
		                </g:if>
		        </div>
		    </div>
		  </div>
		</div>
		
		
		<div class="modal fade" id="basicModal3" tabindex="-1" role="dialog" aria-labelledby="basicModal3" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Close</button>
		            <h3 class="modal-title" id="myModalLabel">Choose a Problem</h3>
		            </div>
		            <div class="modal-body">
		                <select class="form-control" id="contestSelect3" name="contestSelect3">
							<g:each var="problem" in="${problems}" >
								<option id="${'problem'+problem.id}" value="${problem.id}">${problem.name}</option>
							</g:each>
						</select>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		                <a id="goToContest3"class="btn btn-default" href="#" onclick="linkToContest3()">Go</a>
		                <g:if test="${problems.size() == 0}">
		                	<script>
		                		$("#goToContest3").attr('disabled','disabled');
		                	</script>
		                </g:if>
		        </div>
		    </div>
		  </div>
		</div>
		
        
        <h1 align="center" >Welcome ${getCurrentUserName()}</h1>
        <div class="container">
        	<h2>Problems</h2>
            <div class="jumbotron">
              	<a class="btn btn-primary btn-lg" href="uploadProblem">Upload Problem</a>
              	<a class="btn btn-primary btn-lg" href="#" data-toggle="modal" data-target="#basicModal3" >Edit Problem</a>
              	<a class="btn btn-primary btn-lg disabled" href="#">Delete Problem</a>
              	
            </div>
        </div>
        
        <div class="container">
        	<h2>Contest</h2>
            <div class="jumbotron">
              <a class="btn btn-primary btn-lg" href="createContest">Create Contest</a>
              <a class="btn btn-primary btn-lg" href="#" data-toggle="modal" data-target="#basicModal2">Edit Contest</a>
              <a class="btn btn-primary btn-lg disabled">Delete Contest</a>
              <a class="btn btn-primary btn-lg" href="#" data-toggle="modal" data-target="#basicModal">See Contest</a>   
              
            </div>
        </div>
        
        <div class="container">
        	<h2>Ranking</h2>
            <div class="jumbotron">
              <a class="btn btn-primary btn-lg disabled">Check Ranking</a>
            </div>
        </div>
        
        <div class="container">
        	<h2>Users</h2>
            <div class="jumbotron">
              <a class="btn btn-primary btn-lg" href="createUser">Create User</a>
              <a class="btn btn-primary btn-lg disabled">Delete User</a>
              <a class="btn btn-primary btn-lg disabled">Edit User</a>
            </div>
        </div>
        
       
        
       
        
    </body>
</html>
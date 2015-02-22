<!DOCTYPE html>
<html>
    <head>
        <title>Create Contest</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <!-- Bootstrap -->
            
            <link rel="stylesheet" type="text/css"
				href="${resource(dir:'css', file:'bootstrap.min.css')}" />
			<link rel="stylesheet" type="text/css"
				href="${resource(dir:'css', file:'datepicker.css')}" />
				
				<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	        <script src="https://code.jquery.com/jquery.js"></script>        
	        <!-- Include all compiled plugins (below), or include individual files as needed -->
	        <script src="${resource(dir:'', file:'js/moment.js')}"></script>
	        <script src="${resource(dir:'', file:'js/transition.js')}"></script>
	        <script src="${resource(dir:'', file:'js/collapse.js')}"></script>
	        <script src="${resource(dir:'', file:'js/bootstrap.min.js')}"></script>
	        <script src="${resource(dir:'', file:'js/bootstrap-datepicker.js')}"></script>
	        

            <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
            <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
            <!--[if lt IE 9]>
              <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
              <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
            <![endif]-->
    </head>
    <body>
        
        
        <g:render template="/templates/header" />
        
        <script>
        	var addedProblems = [];
        	var names = {};
        	
			function addProblem(){
				var pname = $("#problemsSelect  option:selected").val();
				var id = parseInt(pname.replace("SelectProblem",""));
				if( addedProblems.indexOf(id) != -1 ) return;
				addedProblems.push(id);
				var newChild = '<input type="checkbox" name="'+id+'" checked="checked" />' + names[id] + "<br>";
				$('#addedDiv').append(newChild);
			}

			function getSelectedProblems(){
				var problems = [];
				$('#addedDiv input:checked').each(function() { 
					problems.push($(this).attr('name'));
				});

				return problems;
			}
        </script>
        
        
        
        <div class="container">
        	<div class="jumbotron">
				<g:form  controller='Admin' action='doCreate'>
				    <label>Name</label>
					<input id="titleInput" name="titleInput" class="form-control" placeholder="title">
					<br>
					
					<label>Duration Dates</label>
					<div class='input-group date' id='datetimepicker1'>
						<input type="text" class="form-control" placeholder="start date" id="dp1" name="dp1"  data-date-format="DD/MM/YYYY HH:mm"  >
						<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
						
					</div>
					
					<div class='input-group date' id='datetimepicker2'>
						
						<input type="text" class="form-control"  placeholder="end date" id="dp2" name="dp2" data-date-format="DD/MM/YYYY HH:mm" >
						<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
						
					</div>
					
					<script>
						var format = {};
						$('#dp1').datetimepicker(format);
						$('#dp2').datetimepicker(format);
					</script>
					
					<br>
					<label>Problems</label>
					<br>
					<select class="form-control" id="problemsSelect" name="problemsSelect">
						<g:each var="problem" in="${problems}" >
							<option id="${'SelectProblem'+problem.id}" value="${problem.id}">${problem.name}</option>
							<script>
								names['${problem.id}'] = '${problem.name}';
							</script>
						</g:each>
					</select>
					<br>
					<div class="container" id="addedDiv"></div>
					<br>
					<button type="button" class="btn btn-info" onclick="addProblem()">Add Problem</button>
					<br><br>
					<input class="btn btn-primary btn-lg" type='submit' value="Save"/>
					<br>
					
					<br>
					
				</g:form >
        		
        		<br>
        		<a class="btn btn-primary btn-lg" href="index">Back</a>
        	</div>
        </div>

        
        
    </body>
</html>
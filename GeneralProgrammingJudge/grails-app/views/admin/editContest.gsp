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
        	<h2>Edit ${contest.name}</h2>
        	
            <div class="jumbotron">
               <g:form  controller='Admin' action='doEditContest'>
              		<input type="hidden" value="${contest.id}" name="contestId" />
        			<label>Name</label>
					<input id="name" name="name" class="form-control" placeholder="name" value="${contest.name}">
					<br>
					<label>Duration Dates</label>
					<div class='input-group date' id='datetimepicker1'>
						<input type="text" class="form-control" placeholder="start date" id="dp1" name="dp1"  data-date-format="DD/MM/YYYY HH:mm" value="${startDate}" >
						<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
						
					</div>
					
					<div class='input-group date' id='datetimepicker2'>
						
						<input type="text" class="form-control"  placeholder="end date" id="dp2" name="dp2" data-date-format="DD/MM/YYYY HH:mm" value="${finishDate}" >
						<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
						
					</div>
					
					<script>
						var format = {};
						$('#dp1').datetimepicker(format);
						$('#dp2').datetimepicker(format);
					</script>
					<br>
					<input class="btn btn-primary btn-lg" type='submit' value="Save"/>
        		</g:form>
            </div>
        </div>
        
    </body>
</html>
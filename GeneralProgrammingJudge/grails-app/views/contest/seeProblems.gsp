<!DOCTYPE html>
<html>
    <head>
        <title>${contest.name} - GPJ</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <!-- Bootstrap -->
            
            <link rel="stylesheet" type="text/css"
				href="${resource(dir:'css', file:'bootstrap.min.css')}" />
				
			<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	        <script src="https://code.jquery.com/jquery.js"></script>
	        
	        <!-- Include all compiled plugins (below), or include individual files as needed -->
	        <script src="${resource(dir:'', file:'js/bootstrap.min.js')}"></script>

            <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
            <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
            <!--[if lt IE 9]>
              <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
              <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
            <![endif]-->
    </head>
    <body>
        
        
        <g:render template="/templates/header" />
        <div align="center">
        	<h2>${contest.name}</h2>
        </div>
        <g:if test="${notYet == true}">
        	<div align="center" >
	        	<h1>
	        		The contest hasn't started yet, it will start at: <br> ${startDate}
	        	</h1>
	        </div>
        </g:if>
        <g:else>
        	<g:if test="${finished == true}">
        		<div align="center" >
        			<h1> The contest already finished. </h1>
        		</div>        		
        	</g:if>
        	<g:else>
       			<script>
       				function whenSuccess(data,textStatus){
           				if(data == 'success')
               				console.log('Se guardo el TLE')
               			else
                   			console.log('Error guardando TLE')
           			}
       				function saveTLE(cid,pid){
           				var theParams = 'cid='+cid+'&pid='+pid
       					<g:remoteFunction action="saveTlE" params='theParams' onSuccess="whenSuccess(data,textStatus);" onFailure="onError(XMLHttpRequest,textStatus,errorThrown);"/>
       					
           			}
					function startCounting(problemId,timeToAnswer){
						$("#inputDiv"+problemId).hide();
						$("#outputDiv"+problemId).show();
						$("#tleDiv"+problemId).hide();
						
		
						var rem = timeToAnswer/1000;
						$("#remainingTime"+problemId).html(rem+" seconds remaining");
						var countingId = setInterval(function(){ 
							if(rem >= 0)
								$("#remainingTime"+problemId).html(rem+" seconds remaining");
							else{
								$("#inputDiv"+problemId).show();
								$("#tleDiv"+problemId).show();
								saveTLE(${contest.id},problemId);
								$("#outputDiv"+problemId).hide();
								clearInterval(countingId);
							}
							rem--;
						}, 1000);
					}
		
					function tooglePdf(id){
						
						if( $(id).is(":visible") ){
							$(id).hide();
							$(id+"toogle").html('See Problem description');
						}else{
							$(id).show();
							$(id+"toogle").html('Close Problem description');
						}
		
					}
		        </script>  
		        
		        <g:each var="problem" in="${alreadySolvedProblems}">
		        	<div class="container">
			        	<h2>${problem.name}</h2>
			            <div class="jumbotron">
			            	<h2>
			            		<font color="green">Accepted :)</font> 
							</h2>
			            </div>
			        </div>   
		        </g:each>
		        
		        <g:each var="it" in="${waitingProblems}">
		        	<div class="container">
			        	<h2>${it.problem.name}</h2>
			            <div class="jumbotron">
			            	<h4>
			            		Download the input file, run your program with the file and upload the output together with
			            		your code. Make sure you have enough time to run the code and upload the output once you download the input.
			            	</h4>
			            	<br>
			            	
			            	<div id="pdf${it.problem.id}">
				            	<div class="embed-responsive embed-responsive-4by3">
									<iframe id="iframepdf" src="${createLink(controller:'contest', action:'getPdf', id:it.problem.id)}"></iframe>
								</div>
			            	</div>
			            	<br>
			            	
			            	<a id="pdf${it.problem.id}toogle"class="btn btn-success btn-lg" onclick="tooglePdf('#pdf${it.problem.id}')">See Problem description</a>
			            	<br><br>
			            	<script>
								$('#pdf${it.problem.id}').hide();
			            	</script>
			            	
			            	<div id="tleDiv${it.problem.id}">
					            	<label> 
					            		<font color="blue">Time Limit exceeded :|</font> 
					            		You have no longer time to upload the output, please download another input and try again. 
					            	</label>
					            	<br>
				            	</div>
				            	<script>
									$("#tleDiv${it.problem.id}").hide();
				            	</script>
			            	
		            		<div id="inputDiv${it.problem.id}">
				            	<label>Input</label>
				            	
				            	<br>
				            	<a class="button" onclick="startCounting(${it.problem.id},${it.problem.timeToAnswer})" href="downloadInput?pid=${it.problem.id}&cid=${contest.id}">Download Input</a>
				            	<br><br>
			            	</div>
				            		
			            	<div id="outputDiv${it.problem.id}">
				            	<g:uploadForm  params='[cid:contest.id,pid:it.problem.id]' controller='Contest' action='uploadOutput'>
				            		<label>Output</label>
				            		<label id="remainingTime${it.problem.id}"></label>
							    	<input type='file' name='file'/>
							    	<br>
							    	<input class="btn btn-primary btn-lg" type='submit' value="Submit output"/>
							    	
							    	<script>
							    		startCounting(${it.problem.id},${it.remainingTime})
							    		$("#inputDiv${it.problem.id}").hide()
							    	</script>
				            	</g:uploadForm>
				            </div>
			            </div>
			        </div>   
		        </g:each>
		        
		        
		        <g:each var="problem" in="${toBeDownloadedProblems}">
		        	<div class="container">
			        	<h2>${problem.name}</h2>
			            <div class="jumbotron">
			            	<h4>
			            		Download the input file, run your program with the file and upload the output together with
			            		your code. Make sure you have enough time to run the code and upload the output once you download the input.
			            	</h4>
			            	<br>
			            	
			            	
			            	<div id="pdf${problem.id}">
				            	<div class="embed-responsive embed-responsive-4by3">
									<iframe id="iframepdf" src="${createLink(controller:'contest', action:'getPdf', id:problem.id)}"></iframe>
								</div>
			            	</div>
			            	<br>
			            	
			            	<a id="pdf${problem.id}toogle"class="btn btn-success btn-lg" onclick="tooglePdf('#pdf${problem.id}')">See Problem description</a>
			            	<br><br>
			            	<script>
								$('#pdf${problem.id}').hide();
			            	</script>
			            	
			            	
			            	<div id="inputDiv${problem.id}">
			            		<div id="tleDiv${problem.id}">
					            	<label> 
					            		<font color="blue">Time Limit exceeded :|</font> 
					            		You have no longer time to upload the output, please download another input and try again. 
					            	</label>
					            	<br>
				            	</div>
				            	<script>
									$("#tleDiv${problem.id}").hide();
				            	</script>
					            
				            	<label>Input</label>
				            	<br>
				            	<a class="button" onclick="startCounting(${problem.id},${problem.timeToAnswer})" href="downloadInput?pid=${problem.id}&cid=${contest.id}">Download Input</a>
				            	<br><br>
			            	</div>
			            	
			            	<div id="outputDiv${problem.id}">
				            	<g:uploadForm  params='[cid:contest.id,pid:problem.id]' controller='Contest' action='uploadOutput'>
				            		<label>Output</label>
				            		<label id="remainingTime${problem.id}"></label>
				            		
							    	<input type='file' name='file'/>
							    	<br>
							    	<input class="btn btn-primary btn-lg" type='submit' value="Submit output"/>
				            	</g:uploadForm>
				            </div>
				            
				            <script>
				            	$("#outputDiv${problem.id}").hide();
				            </script>
			            </div>
			        </div>   
		        </g:each>  
        	</g:else>
        </g:else>
    </body>
</html>
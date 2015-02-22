<h2>General Programming Judge</h2>
 <!-- Navbar -->
<div class="navbar navbar-default navbar-static-top" role="navigation">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">GPJ</a>
    </div>
    <div class="navbar-collapse collapse">
      <ul class="nav navbar-nav">
      	
		
		<li class="active"><a href="${createLinkToHome()}">Home</a></li>
        
        <li><a href="${createLink(controller:'contest', action:'index')}">Contests</a></li>
        <li><a href="${createLink(controller:'auth',action:'signOut') }">Logout</a></li>
      </ul>
      
    </div><!--/.nav-collapse -->
  </div>
</div>
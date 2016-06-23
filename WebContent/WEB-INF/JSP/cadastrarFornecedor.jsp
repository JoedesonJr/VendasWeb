<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Cadastrar Fornecedor</title>
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/login.css" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
</head>
<body>
	<div class="container" style="margin-top: 10px;">
		<ul class="nav nav-tabs">
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=index">Home</a></li>
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=venda">Venda</a></li>
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarProduto">Produto</a></li>
		  <li role="presentation" class="active"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarFornecedor">Fornecedor</a></li>
		</ul>
		
		<ol class="breadcrumb" style="margin-top: 30px;">
  			<li class="active">Cadastrar Fornecedor</li>
  			<li><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=modificarFornecedor">Modificar Fornecedor</a></li>
		</ol>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<h1> <span class="fa fa-pencil"></span>   Cadastrar Fornecedor</h1>
				
				<c:if test="${status == 'cadastroFornecedor'}">
					<c:import url="mensagem.jsp" />
				</c:if>
				
				<c:if test="${status == 'erro_cadastroFornecedor'}">
					<c:import url="mensagem.jsp" />
				</c:if>

				<form name="form1" action="/joedesonJrParte1/mvc?logica=cadastrarFornecedor_Logica" method="post" style="margin-top: 30px;">
					 <div class="form-group">
						<label for="razaosocial"> Razão Social </label>
					 	<input type="text" class="form-control" id="razaosocial" name="razaosocial" placeholder="Razão Social">
					 </div>
					 
					 <div class="form-group">
					 	<label for="produtos"> Produtos deste Fornecedor: </label>
					 	
					 	<c:forEach var="produtos" items="${produtos}">
                        	<div class="checkbox">
    							<label>
                            		<input type="checkbox" name="${produtos.descricao}" value="${produtos.codigo}"> ${produtos.descricao}
    							</label>
    						</div>
                        </c:forEach>
					 </div>
					 
		  			 <button type="submit" class="btn btn-success" style="margin-top:10px;" onClick="return validaForm()"> Cadastrar </button>
				</form>
			</div>
			<div class="col-md-1"></div>
		</div>
		<hr style="margin-top: 50px;">
        <footer class="footer text-center">
        	<p> <span class="text-info">&copy; 2016</span> <span class="text-muted"><strong>Avaliação Internet B</strong>, CSI/UFSM.</span> </p>
        </footer>
	</div>
    
    <script type="text/javascript">
		function validaForm() {			
                var razaosocial = form1.razaosocial.value;
				
                if(razaosocial.length <= 0){
                	bootbox.alert({
                        message: '<center></center><br/><h2 class="alert alert-warning text-center">Por favor, defina uma Razão Social!</h2>',
                    });
                    form1.razaosocial.focus();
                    return false;
                }
		}
	</script>
     
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/bootbox.min.js"></script>
</body>
</html>
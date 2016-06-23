<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Alterar Produto</title>
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/login.css" rel="stylesheet">
	<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
</head>
<body>
	<div class="container" style="margin-top: 10px;">
		<ul class="nav nav-tabs">
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=index">Home</a></li>
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=venda">Venda</a></li>
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarProduto">Produto</a></li>
		  <li role="presentation" class="active"><a href="#">Fornecedor</a></li>
		</ul>
		
		<ol class="breadcrumb" style="margin-top: 30px;">
  			<li><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarFornecedor">Cadastrar Fornecedor</a></li>
  			<li><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=modificarFornecedor">Modificar Fornecedor</a></li>
  			<li class="active">Alterar Fornecedor</li>
		</ol>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<h1> Alterar Fornecedor </h1>

				<form action="/joedesonJrParte1/mvc?logica=alterarFornecedor_Logica&&id=${fornecedorAlterar}" method="post" style="margin-top: 30px;">
					<div class="form-group">
						<label for="razaosocial"> Razão Social </label>
					 	<input type="text" class="form-control" id="razaosocial" name="razaosocial" value ="${fornecedor.razaoSocial}" placeholder="${fornecedor.razaoSocial}">
					 </div>
					 <div class="form-group">
					 	<label for="produtos"> Produtos deste Fornecedor: </label>
					 	
					 	<c:forEach var="produtos" items="${produtos}">
                        	<div class="checkbox">
    							<label>
    								<c:set var="teste" value="0"/>
    								<c:forEach var="prodforc" items="${fornecedor.produtos}">
    										<c:if test="${teste == '0'}">
    											<c:if test="${prodforc.codigo == produtos.codigo}">
    												<input type="checkbox" name="${produtos.descricao}" value="${produtos.codigo}" checked> ${produtos.codigo} - ${produtos.descricao}
    												<c:set var="teste" value="1"/>
    											</c:if>
    										</c:if>
                            		 </c:forEach>
                            		 <c:if test="${teste == '0'}">
										<input type="checkbox" name="${produtos.descricao}" value="${produtos.codigo}"> ${produtos.codigo} - ${produtos.descricao}
									</c:if>
    							</label>
    						</div>
                        </c:forEach>
					 </div>
		  			 <button type="submit" class="btn btn-success"> Alterar </button>
				</form>
			</div>
			<div class="col-md-1"></div>
		</div>
		<hr style="margin-top: 50px;">
        <footer class="footer text-center">
        	<p> <span class="text-info">&copy; 2016</span> <span class="text-muted"><strong>Avaliação Internet B</strong>, CSI/UFSM.</span> </p>
        </footer>
	</div>
        
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>
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
		  <li role="presentation" class="active"><a href="#">Produto</a></li>
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarFornecedor">Fornecedor</a></li>
		</ul>
		
		<ol class="breadcrumb" style="margin-top: 30px;">
  			<li><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarProduto">Cadastrar Produto</a></li>
  			<li><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=modificarProduto">Modificar Produto</a></li>
  			<li class="active">Alterar Produto</li>
		</ol>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<h1> Alterar Produto </h1>

				<form action="/joedesonJrParte1/mvc?logica=alterarProduto_Logica&&id=${produtoAlterar}" method="post" style="margin-top: 30px;">
					<div class="form-group">
						<label for="descricao"> Descrição </label>
					 	<input type="text" class="form-control" id="descricao" name="descricao" value ="${produto.descricao}" placeholder="${produto.descricao}">
					 </div>
					 <div class="form-group">
					 	<label for="fornecedor"> Fornecedores deste Produto>: </label>
					 	
					 	<c:forEach var="fornecedor" items="${fornecedores}">
                        	<div class="checkbox">
    							<label>
    								<c:set var="teste" value="0"/>
    								<c:forEach var="prodforc" items="${produto.fornecedores}">
    										<c:if test="${teste == '0'}">
    											<c:if test="${prodforc.codigo == fornecedor.codigo}">
    												<input type="checkbox" name="${fornecedor.razaoSocial}" value="${fornecedor.codigo}" checked> ${fornecedor.codigo} - ${fornecedor.razaoSocial}
    												<c:set var="teste" value="1"/>
    											</c:if>
    										</c:if>
                            		 </c:forEach>
                            		 <c:if test="${teste == '0'}">
										<input type="checkbox" name="${fornecedor.razaoSocial}" value="${fornecedor.codigo}"> ${fornecedor.codigo} - ${fornecedor.razaoSocial}
									</c:if>
    							</label>
    						</div>
                        </c:forEach>
					 </div>
					 <div class="form-group">
					    <label for="preco"> Preço </label>
					    <input type="text" class="form-control" id="preco"  name="preco" value="${produto.preco}" placeholder="${produto.preco}">
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
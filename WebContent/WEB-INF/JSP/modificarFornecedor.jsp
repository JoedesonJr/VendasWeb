<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modificar Fornecedor</title>
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/login.css" rel="stylesheet">
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
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
			<li><a
				href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarFornecedor">Cadastrar
					Fornecedor</a></li>
			<li class="active">Modificar Fornecedor</li>
		</ol>

		<div class="row" style="margin-top: 20px;">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<h1> <span class="fa fa-edit"></span>   Modificar Fornecedor</h1>

				<c:if test="${status == 'deletarFornecedor'}">
					<c:import url="mensagem.jsp" />
				</c:if>

				<c:if test="${status == 'erro_deletarFornecedor'}">
					<c:import url="mensagem.jsp" />
				</c:if>

				<c:if test="${status == 'atualizarFornecedor'}">
					<c:import url="mensagem.jsp" />
				</c:if>

				<c:if test="${status == 'erro_atualizarFornecedor'}">
					<c:import url="mensagem.jsp" />
				</c:if>

				<section style="margin-top: 30px;">
				<table class="table table-bordered">
					<thead>
						<tr>
						<tr>
							<th>Razão Social</th>
							<th>Produtos</th>
							<th>Ações</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="fornecedor" items="${fornecedores}">
							<tr>
								<td>${fornecedor.razaoSocial}</td>
								<td>
									<c:forEach var="produto" items="${fornecedor.produtos}"> 
										<strong>/</strong>  <span class="text-info"> ${produto.descricao} </span>
									</c:forEach></td>
								<td>
									<a class="btn btn-success fa fa-wrench "
										href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&id=${fornecedor.codigo}&&direciona=alterarFornecedor"
										title="Alterar Produto">
									</a>
									<a	class="btn btn-danger fa fa-remove"
										href="/joedesonJrParte1/mvc?logica=removerFornecedor_Logica&&id=${fornecedor.codigo}"
										title="Deletar Produto"> 
									</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</section>
			</div>
			<div class="col-md-1"></div>
		</div>
		<hr style="margin-top: 50px;">
        <footer class="footer text-center">
        	<p> <span class="text-info">&copy; 2016</span> <span class="text-muted"><strong>Avaliação Internet B</strong>, CSI/UFSM.</span> </p>
        </footer>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
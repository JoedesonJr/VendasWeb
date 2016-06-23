<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Modificar Produto</title>
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
			<li role="presentation" class="active"><a href="#">Produto</a></li>
			<li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarFornecedor">Fornecedor</a></li>
		</ul>

		<ol class="breadcrumb" style="margin-top: 30px;">
			<li><a
				href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarProduto">Cadastrar
					Produto</a></li>
			<li class="active">Modificar Produto</li>
		</ol>

		<div class="row" style="margin-top: 20px;">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<h1> <span class="fa fa-edit"></span>   Modificar Produto</h1>

				<c:if test="${status == 'deletar'}">
					<c:import url="mensagem.jsp" />
				</c:if>

				<c:if test="${status == 'erro_deletar'}">
					<c:import url="mensagem.jsp" />
				</c:if>

				<c:if test="${status == 'atualizar'}">
					<c:import url="mensagem.jsp" />
				</c:if>

				<c:if test="${status == 'erro_atualizar'}">
					<c:import url="mensagem.jsp" />
				</c:if>

				<section style="margin-top: 30px;">
				<table class="table table-bordered">
					<thead>
						<tr>
						<tr>
							<th>Descrição</th>
							<th>Preço</th>
							<th>Fornecedores</th>
							<th>Ações</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="produto" items="${produtos}">
							<tr>
								<td>${produto.descricao}</td>
								<td><strong>R$</strong> ${produto.preco}</td>
								<td>
									<c:forEach var="fornecedor"	items="${produto.fornecedores}"> 
										<strong>/</strong>  <span class="text-info"> ${fornecedor.razaoSocial} </span>
									</c:forEach></td>
								<td>
									<a class="btn btn-success fa fa-wrench"
										href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&id=${produto.codigo}&&direciona=alterar"
										title="Alterar Produto">
									</a>
									<a	class="btn btn-danger fa fa-remove"
										href="/joedesonJrParte1/mvc?logica=removerProduto_Logica&&id=${produto.codigo}"
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
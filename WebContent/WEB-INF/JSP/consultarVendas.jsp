<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Venda</title>
	<link href="css/bootstrap.css" rel="stylesheet">
	<link href="css/login.css" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
</head>
<body>
	<div class="container" style="margin-top: 10px;">
		<ul class="nav nav-tabs">
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=index">Home</a></li>
		  <li role="presentation" class="active"><a href="#">Venda</a></li>
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarProduto">Produto</a></li>
		  <li role="presentation"><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=cadastrarFornecedor">Fornecedor</a></li>
		</ul>
		
		<ol class="breadcrumb" style="margin-top: 30px;">
  			<li><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=venda">Registrar Venda</a></li>
  			<li class="active">Consultar Vendas</li>
		</ol>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<h1> <span class="fa fa-line-chart"></span>   Consultar Vendas</h1>

				<section style="margin-top: 30px;">
				<table class="table table-bordered">
					<thead>
						<tr>
						<tr>
							<th>Codigo</th>
							<th>Data</th>
							<th>Cliente</th>
							<th>Items</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="venda" items="${vendas}">
							<tr>
								<td> ${venda.codigo} </td>
								<td> ${venda.data} </td>
								<td> ${venda.cliente} </td>
								<td> 
									<button type="button" class="btn btn-info" 
										data-toggle="modal" data-target="#items" onclick="modal(${venda.codigo})">Item(s)</button>	
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
	
	<div class="modal fade" id="items" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Item(s) da Venda</h4>
				</div>
				
				<div class="modal-body">
					<div class="row">
						<div class="col-md-2"></div>
						<div class="col-md-5">
							<div id="dadosCliente"></div>	
						</div>
						<div class="col-md-5">
							<div id="dadosData"></div>
						</div>
					</div>
					<hr>
					<div class="row">
						<div class="col-md-12">
							<table id="itemscompra" class="table table-bordered" style="margin-top: 20px;">
								<thead>
									<tr>
										<th>Descrição</th>
										<th>Preço Unid.</th>
										<th>Quantidade</th>
										<th>Total</th>
									</tr>
								</thead>
								<tbody>
									<tr>
				
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="row">
						<div class="col-md-5"><div id="total"></div></div>
						<div class="col-md-3"></div>
						<div class="col-md-4"></div>
					</div>						
					<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>
		
	<script type="text/javascript">
		function modal(codVenda) {
			var divData = document.getElementById("dadosData");
			var divCliente = document.getElementById("dadosCliente");
			var divTotal = document.getElementById("total");
			
			var cliente;
			var data;
			var soma = 0;
				
			var table = document.getElementById("itemscompra");
				
			for (var i=table.rows.length-1; i > 0; i--) {
				table.deleteRow(i); 
			}
				
			<c:forEach items="${vendas}" var="venda">
				if('${venda.codigo}' == codVenda){
					cliente = '${venda.cliente}';
					data = '${venda.data}';
						
					divCliente.innerHTML = "<h4> <strong>Cliente:</strong> <small>" +cliente+ "</small> </h4>";
					divData.innerHTML = "<h4> <strong>Data:</strong> <small>" +data+ "</small> </h4>";
						
					<c:forEach items="${venda.itemsVenda}" var="item">
			           	var descricao = '${item.descricao}';
			           	var quantidade = '${item.quantidade}';
			           	var precoUnid = '${item.precoUnid}';
			           	var total = '${item.total}';
							
						var novaLinha = table.insertRow(1);
			           		
			            for (var j = 0; j < 4; j++) {  // cria as colunas
				        	newCell = novaLinha.insertCell(j); // inseri uma coluna na nova linha 
				                
				            if(j == 0){
				            	newCell.innerHTML = descricao;
				            }if(j == 1){
								newCell.innerHTML = '<strong>R$</strong> ' +parseFloat(precoUnid).toFixed(2);
				            }if(j == 2){
								newCell.innerHTML = quantidade;
				            }if(j == 3){
								newCell.innerHTML = '<strong>R$</strong> ' +parseFloat(total).toFixed(2);
				            }     
				        }
			                
			            soma += parseFloat(total);
					</c:forEach>
						
					divTotal.innerHTML = "<h4> <strong>Total da venda:</strong> <small> <strong>R$ </strong>" +soma.toFixed(2)+ "</small> </h4>";
				}
			</c:forEach>
		}
	</script>
		
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>
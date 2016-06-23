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
  			<li class="active">Registrar Venda</li>
  			<li><a href="/joedesonJrParte1/mvc?logica=redireciona_Logica&&direciona=consultarVenda">Consultar Vendas</a></li>
		</ol>
		
		<div class="row" style="margin-top: 20px;">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<h1> <span class="fa fa-pencil"></span>   Registrar Venda</h1>
				
				<c:if test="${status == 'vendaItem'}">
					<c:import url="/WEB-INF/JSP/mensagem.jsp" />
				</c:if>
				<c:if test="${status == 'erro_vendaItem'}">
					<c:import url="mensagem.jsp" />
				</c:if>
			
				<form name="form1" action="/joedesonJrParte1/mvc?logica=itemVenda_Logica" method="post">
					<div class="form-group">
						<hr>
						<div class="row">
							<div class="col-md-6">
								<label for="cliente"> Cliente </label>	
								<select class="form-control" name="cliente" id="cliente">
									<option> --- </option>
									<c:forEach var="clientes" items="${clientes}">
										<option value="${clientes.cliente}"> ${clientes.nome} </option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="data"> Data </label>
						 			<input type="date" class="form-control" id="data" name="data" placeholder="Data">
						 		</div>
							</div>
						</div>
					</div>
					 
					<hr>
					<h2> <span class="fa fa-shopping-basket"></span>    Produtos</h2>

					<div class="form-group" style="margin-top: 30px;">
						<div class="row">
					 		<div class="col-md-6">
					 			<label for="produtos"> Descrição: </label>
					 			
								<select class="form-control" id="descricao" name="descricao" onchange="complete()">
							 		<option> --- </option>
									<c:forEach var="produtos" items="${produtos}">
										<option value="${produtos.codigo} ${produtos.preco} ${produtos.descricao}"> ${produtos.descricao} </option>
									</c:forEach>
							 	</select>
							</div>
							<div class="col-md-6">
					 			<label for="quantidade"> Quantidade  </label>
					 			<input type="number" class="form-control" id="quantidade" name="quantidade" value="0" onchange="calcula()" >
							</div>
						</div>	
					</div>
	
					<div class="form-group">
						<div class="row">
							<div class="col-md-6">
								<label for="preco"> Preço unid. </label>
								<input type="text" class="form-control" id="preco" name="preco" disabled>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="total"> Total </label>
							 		<input type="text" class="form-control" id="total" name="total" disabled>
							 	</div>
							</div>
						</div>
					</div>
			  		<button type="button" class="btn btn-success pull-right" onclick="carrinhoCompras()"> Adicionar </button>
				
					<h2 style="margin-top: 40px;"> <span class="fa fa-cart-plus"></span>   Item(s) Compra </h2>
				 		 						
					<table id="itemcompra" class="table table-bordered" style="margin-top: 20px;">
						<thead>
							<tr>
								<th>Descrição</th>
								<th>Preço Unid.</th>
								<th>Quantidade</th>
								<th>Total</th>
								<th>Remover</th>
							</tr>
						</thead>
						<tbody>
							<tr>
	
							</tr>
						</tbody>
					</table>
					
					<div class="row">
						<div class="col-lg-4 pull-left">
							<label for="totalvenda" class="">Total da Venda:</label> 
							<input type="text" id="totalvenda" name="totalvenda" class="form-control" value = "0">
						</div>
						<div class="col-lg-4"></div>
						<div class="col-lg-4"> 
							<button type="submit" class="btn btn-success pull-right" style="margin-top: 10px;" onClick="return validaForm();">Finalizar Venda </button> 
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="col-md-1"></div>
			
		<hr style="margin-top: 50px;">
        <footer class="footer text-center">
        	<p> <span class="text-info">&copy; 2016</span> <span class="text-muted"><strong>Avaliação Internet B</strong>, CSI/UFSM.</span> </p>
        </footer>
	</div>
	
	</div>
	
	<script type="text/javascript">
		function validaForm() {	 // valida o formulario não permitindo campos invalidos		
                var cliente = form1.cliente.value;
                var data = form1.data.value;
                var produtos = document.getElementById('itemcompra').rows;
				
                if(cliente == '---'){  // não deixa que a compra seja finalizada sem um cliente
                	bootbox.alert({
                        message: '<center></center><br/><h2 class="alert alert-warning text-center">Por favor, defina um Cliente!</h2>',
                    });
                    form1.cliente.focus();
                    return false;
                }
                if(data.length < 5){  // não deixa que a compra seja finalizada sem uma data
                	bootbox.alert({
                        message: '<center></center><br/><h2 class="alert alert-warning text-center">Por favor, defina uma Data!</h2>',
                    });
                    form1.data.focus();
                    return false;
                }
                if(produtos.length <= 2){  // não deixa que a compra seja finalizada sem um produto
                	bootbox.alert({
                        message: '<center></center><br/><h2 class="alert alert-warning text-center">Por favor, adicione um Produto a compra!</h2>',
                    });
                    return false;
                }
		}

		function calcula() {  // calcula o valor total do produto selecionado
		    var qtd = document.getElementById("quantidade").value;
		    var preco = document.getElementById("preco").value;
		    
		    document.getElementById("total").value = (parseFloat(qtd) * parseFloat(preco)).toFixed(2);
		}

		function complete() {  // completa o formulario com o preço do produto selecionado
		    var preco = document.getElementById("descricao").value.split(" ",3);
		    var qtd = document.getElementById("quantidade").value;
		    
		    preco = preco[1];
		    
			document.getElementById("preco").value = parseFloat(preco).toFixed(2);
			document.getElementById("total").value = (parseFloat(qtd) * parseFloat(preco)).toFixed(2);
		}

		function soma(){  // apos todos os produtos adicionados no carrinho de compra, soma o total da venda
			var soma = 0;
			var trs = document.getElementById('itemcompra').rows ;
			var todos = null ;
			for ( var i = 1 ; i < trs.length ; i++ )  // percorre toda a tabela de carrinho de compras
			{
				todos = trs[i].cells ;
				for ( var j = 3 ; j < todos.length && j <= 3; j++ ){
						if(todos[j].innerHTML != null)
							soma += parseFloat(todos[j].innerHTML);  // somando o valor total dos produtos
				}
			}
			
			document.getElementById("totalvenda").value = soma.toFixed(2);
		}

		function Excluir(self){  // retira do carinho produtos selecionados
    		var par = $(self).parent().parent();
    		par.remove();
		}

		function produtoRepetido(descricao){  // não permite que sejam adicionados ao carrinho produtos repetidos
			var trs = document.getElementById('itemcompra').rows;
			var todos = null ;
			for ( var i = 1 ; i < trs.length ; i++ )  // varre toda a tabela de carrinho de compras
			{
				todos = trs[i].cells ;
				for ( var j = 0 ; j < todos.length && j <= 0; j++ ){
					if(todos[j].innerHTML == descricao){  // e se encontra o produto selecionado avisa com uma mensagem
						bootbox.alert({
                            message: '<center></center><br/><h2 class="alert alert-danger text-center">Produto já existente no carrinho!</h2>',
                        });
						return 1;
					}
				}
			}
			return 0;
		}

        function carrinhoCompras() {  // adiciona produtos ao carrinho de compra

            var table = document.getElementById("itemcompra");
           
            var novaLinha = table.insertRow(1);  // inseri um linha no final da tabela
            
            var descricao = document.getElementById("descricao").options[document.getElementById("descricao").selectedIndex].text;
            var total = document.getElementById("total").value;
            var quantidade = document.getElementById("quantidade").value;
            var preco = document.getElementById("descricao").value.split(" ",3);
        	var codigo = preco[0];
        	preco = parseFloat(preco[1]).toFixed(2);
        	
        	if(quantidade <= 0)  // não permite add produtos sem uma quantidade
        		bootbox.alert({
                    message: '<center></center><br/><h2 class="alert alert-warning text-center">Por favor, defina uma Quantidade!</h2>',
            });
        	else if(descricao == '---')  // não permite add produtos não selecionados
        		bootbox.alert({
                    message: '<center></center><br/><h2 class="alert alert-warning text-center">Por favor, defina um Produto!</h2>',
            });
        	else if (produtoRepetido(descricao) == 0){  // se o produtos selecionado não existir no carrinho, inseri
	            for (var j = 0; j < 5; j++) {  // cria as colunas
	
	                newCell = novaLinha.insertCell(j); // inseri uma coluna na nova linha 
	                
	                // inseri o conteudo 
	                if(j == 0){
	                	newCell.innerHTML = descricao;
	                }if(j == 1){
						newCell.innerHTML = preco;
	                }if(j == 2){
						newCell.innerHTML = quantidade;
	                }if(j == 3){
						newCell.innerHTML = total;
	                }if(j == 4){
						newCell.innerHTML = ' <a class="btn btn-danger fa fa-remove" '
							+ ' onClick="Excluir(this), soma()" '
							+ ' title="Remover"> </a>'
							
							+  '<input type="hidden" name="'+codigo+'"  id="x"  value="'+codigo +'-'+quantidade+'">';
	                }
	                
	            }
	            soma();  // soma todos os produtos existentes no carrinho
        	}
        } 
	</script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/bootbox.min.js"></script>
</body>
</html>
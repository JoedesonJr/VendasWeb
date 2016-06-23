<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 

<link rel="stylesheet" type="text/css" href="css/bootstrap.css">

    <c:if test="${status == 'cadastro'}"> 
        <div class="alert alert-success" role="alert">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Ok! Produto Cadastrado.</strong> </div>
    </c:if> 
    
    <c:if test="${status == 'cadastroFornecedor'}"> 
        <div class="alert alert-success" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Ok! Fornecedor Cadastrado.</strong> </div>
    </c:if> 
        
    <c:if test="${status == 'deletar'}"> 
        <div class="alert alert-success" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Ok! Produto Deletado.</strong> </div>
    </c:if>
        
    <c:if test="${status == 'deletarFornecedor'}"> 
        <div class="alert alert-success" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Ok! Fornecedor Deletado.</strong> </div>
    </c:if>
        
    <c:if test="${status == 'atualizar'}"> 
        <div class="alert alert-success" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Ok! Produto Alterado.</strong> </div>
    </c:if> 

	<c:if test="${status == 'atualizarFornecedor'}"> 
        <div class="alert alert-success" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Ok! Fornecedor Alterado.</strong> </div>
    </c:if> 

	<c:if test="${status == 'vendaItem'}"> 
        <div class="alert alert-success" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Ok! Venda Finalizada.</strong> </div>
    </c:if> 

	<c:if test="${status == 'erro_vendaItem'}"> 
        <div class="alert alert-danger" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Opa! Venda não finalizada.</strong> </div>
    </c:if>

    <c:if test="${status == 'erro_cadastro'}"> 
        <div class="alert alert-danger" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Opa! Produto não Cadastrado.</strong> </div>
    </c:if>
    
    <c:if test="${status == 'erro_cadastroFornecedor'}"> 
        <div class="alert alert-danger" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Opa! Fornecedor não Cadastrado.</strong> </div>
    </c:if>
        
    <c:if test="${status == 'erro_deletarFornecedor'}"> 
        <div class="alert alert-danger" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Opa! Fornecedor não Deletado.</strong> </div>
    </c:if>
        
        
    <c:if test="${status == 'erro_atualizar'}"> 
        <div class="alert alert-danger" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Opa! Produto não Alterado.</strong> </div>
    </c:if> 
    
    <c:if test="${status == 'erro_atualizarFornecedor'}"> 
        <div class="alert alert-danger" role="alert"> 
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <strong>Opa! Fornecedor não Alterado.</strong> </div>
    </c:if> 

<c:set var="status" value="vazio" scope="session" />

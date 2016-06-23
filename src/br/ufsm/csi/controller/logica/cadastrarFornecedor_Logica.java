package br.ufsm.csi.controller.logica;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufsm.csi.model.Fornecedor;
import br.ufsm.csi.model.Produto;
import br.ufsm.csi.model.DAO.FornecedorDAO;
import br.ufsm.csi.model.DAO.ProdutoDAO;

public class cadastrarFornecedor_Logica implements Logica{

	@Override
	public String executa(HttpServletRequest request, HttpServletResponse response) {
		// todos os produtos
		request.setAttribute("produtos", new ProdutoDAO().lista());
		
		Fornecedor fornecedor = new Fornecedor();
		// Todos os produtos cadastrados
		ArrayList<Produto> produto = new ProdutoDAO().lista();
		
		ArrayList<Produto> produtos = new ArrayList<Produto>();
		// Encontra os fornecedores que foram selecionados no Chekbox
		for (int i=0; i < produto.size(); i++) {
			if(request.getParameter(produto.get(i).getDescricao()) != null){
				Produto p = new Produto();

				p.setCodigo(produto.get(i).getCodigo());
				p.setDescricao(produto.get(i).getDescricao());
				p.setPreco(produto.get(i).getPreco());
				// E adiciona numa coleção
				produtos.add(p);
			}
		}
		
		fornecedor.setRazaoSocial(request.getParameter("razaosocial"));
		fornecedor.setProdutos(produtos);
		
		String pagina = "/WEB-INF/JSP/cadastrarFornecedor.jsp";
		
		try {
			boolean retorno = new FornecedorDAO().inserir(fornecedor);
		
			if(retorno)			
				request.setAttribute("status", "cadastroFornecedor");
			else
				request.setAttribute("status", "erro_cadastroFornecedor");
			
		} catch (Exception e) {
			e.printStackTrace();
			
			return pagina;
		}

		return pagina;
	}

}

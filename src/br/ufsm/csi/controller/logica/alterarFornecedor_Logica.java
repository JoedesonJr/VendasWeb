package br.ufsm.csi.controller.logica;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufsm.csi.model.Fornecedor;
import br.ufsm.csi.model.Produto;
import br.ufsm.csi.model.DAO.FornecedorDAO;
import br.ufsm.csi.model.DAO.ProdutoDAO;

public class alterarFornecedor_Logica implements Logica{

	@Override
	public String executa(HttpServletRequest request, HttpServletResponse response) {
		
		Fornecedor fornecedor = new Fornecedor();
		
		ArrayList<Produto> produto = new ProdutoDAO().lista();
		
		ArrayList<Produto> produtos = new ArrayList<Produto>();
		
		for (int i=0; i < produto.size(); i++) {
			if(request.getParameter(produto.get(i).getDescricao()) != null){
				Produto p = new Produto();

				p.setCodigo(produto.get(i).getCodigo());
				p.setDescricao(produto.get(i).getDescricao());

				produtos.add(p);
			}
		}
		
		fornecedor.setCodigo(Integer.parseInt(request.getParameter("id")));
		fornecedor.setRazaoSocial(request.getParameter("razaosocial"));
		fornecedor.setProdutos(produtos);
		
		FornecedorDAO fDAO = new FornecedorDAO();
		
		String pagina = "/WEB-INF/JSP/modificarFornecedor.jsp";
		
		try {
			boolean retorno = fDAO.atualizar(fornecedor);
		
			request.setAttribute("fornecedores", new FornecedorDAO().getFornecedores());
			
			if(retorno)			
				request.setAttribute("status", "atualizarFornecedor");
			else
				request.setAttribute("status", "erro_atualizarFornecedor");
		} catch (Exception e) {
			e.printStackTrace();
			
			return pagina;
		}
		
		return pagina;
	}

}

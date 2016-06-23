package br.ufsm.csi.controller.logica;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufsm.csi.model.Produto;
import br.ufsm.csi.model.DAO.FornecedorDAO;
import br.ufsm.csi.model.DAO.ProdutoDAO;
import br.ufsm.csi.model.Fornecedor;

public class cadastrarProduto_Logica implements Logica{

	@Override
	public String executa(HttpServletRequest request, HttpServletResponse response) {
		
		request.setAttribute("fornecedores", new FornecedorDAO().getFornecedores());
		
		Produto produto = new Produto();
		// Todos os forncedores cadastrados
		ArrayList<Fornecedor> fornecedor = new FornecedorDAO().getFornecedores();
		
		ArrayList<Fornecedor> fornecedores = new ArrayList<Fornecedor>();
		// Encontra os fornecedores que foram selecionados no Chekbox
		for (int i=0; i < fornecedor.size(); i++) {
			if(request.getParameter(fornecedor.get(i).getRazaoSocial()) != null){
				Fornecedor f = new Fornecedor();

				f.setCodigo(fornecedor.get(i).getCodigo());
				f.setRazaoSocial(fornecedor.get(i).getRazaoSocial());
				// E adiciona numa coleção
				fornecedores.add(f);
			}
		}
		
		produto.setDescricao(request.getParameter("descricao"));
		produto.setPreco(Float.parseFloat(request.getParameter("preco")));
		produto.setFornecedores(fornecedores);
		
		String pagina = "/WEB-INF/JSP/cadastrarProduto.jsp";
		
		try {
			boolean retorno = new ProdutoDAO().inserir(produto);
		
			if(retorno)			
				request.setAttribute("status", "cadastro");
			else
				request.setAttribute("status", "erro_cadastro");
			
		} catch (Exception e) {
			e.printStackTrace();
			
			return pagina;
		}

		return pagina;
	}

}

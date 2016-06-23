package br.ufsm.csi.controller.logica;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufsm.csi.model.Fornecedor;
import br.ufsm.csi.model.Produto;
import br.ufsm.csi.model.DAO.FornecedorDAO;
import br.ufsm.csi.model.DAO.ProdutoDAO;

public class alterarProduto_Logica implements Logica{

	@Override
	public String executa(HttpServletRequest request, HttpServletResponse response) {
		
		Produto produto = new Produto();
		
		ArrayList<Fornecedor> fornecedor = new FornecedorDAO().getFornecedores();
		
		ArrayList<Fornecedor> fornecedores = new ArrayList<Fornecedor>();
		
		for (int i=0; i < fornecedor.size(); i++) {
			if(request.getParameter(fornecedor.get(i).getRazaoSocial()) != null){
				Fornecedor f = new Fornecedor();

				f.setCodigo(fornecedor.get(i).getCodigo());
				f.setRazaoSocial(fornecedor.get(i).getRazaoSocial());

				fornecedores.add(f);
			}
		}
		
		produto.setCodigo(Integer.parseInt(request.getParameter("id")));
		produto.setDescricao(request.getParameter("descricao"));
		produto.setPreco(Float.parseFloat(request.getParameter("preco")));
		produto.setFornecedores(fornecedores);
		
		ProdutoDAO pDAO = new ProdutoDAO();
		
		String pagina = "/WEB-INF/JSP/modificarProduto.jsp";
		
		try {
			boolean retorno = pDAO.atualizar(produto);
		
			request.setAttribute("produtos", new ProdutoDAO().lista());
			
			if(retorno)			
				request.setAttribute("status", "atualizar");
			else
				request.setAttribute("status", "erro_atualizar");
		} catch (Exception e) {
			e.printStackTrace();
			
			return pagina;
		}
		
		return pagina;
	}

}

package br.ufsm.csi.controller.logica;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufsm.csi.model.DAO.FornecedorDAO;
import br.ufsm.csi.model.DAO.ProdutoDAO;

public class removerFornecedor_Logica implements Logica{

	@Override
	public String executa(HttpServletRequest request, HttpServletResponse response) {
		
		FornecedorDAO fDAO = new FornecedorDAO();
		
		String pagina = "/WEB-INF/JSP/modificarFornecedor.jsp";
		
		try {
			boolean retorno = fDAO.remove(Long.parseLong(request.getParameter("id")));
			
			if(retorno)			
				request.setAttribute("status", "deletarFornecedor");
			else
				request.setAttribute("status", "erro_deletarFornecedor");
		} catch (Exception e) {
			e.printStackTrace();
			
			return pagina;
		}
		request.setAttribute("fornecedores", new FornecedorDAO().getFornecedores());
		
		return pagina;
	}

}

package br.ufsm.csi.controller.logica;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufsm.csi.model.DAO.ProdutoDAO;

public class removerProduto_Logica implements Logica{

	@Override
	public String executa(HttpServletRequest request, HttpServletResponse response) {
		
		ProdutoDAO pDAO = new ProdutoDAO();
		
		String pagina = "/WEB-INF/JSP/modificarProduto.jsp";
		
		try {
			boolean retorno = pDAO.remove(Long.parseLong(request.getParameter("id")));
			
			if(retorno)			
				request.setAttribute("status", "deletar");
			else
				request.setAttribute("status", "erro_deletar");
		} catch (Exception e) {
			e.printStackTrace();
			
			return pagina;
		}
		request.setAttribute("produtos", new ProdutoDAO().lista());
		
		return pagina;
	}

}

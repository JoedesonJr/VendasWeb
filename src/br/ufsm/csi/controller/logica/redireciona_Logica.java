package br.ufsm.csi.controller.logica;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufsm.csi.model.DAO.FornecedorDAO;
import br.ufsm.csi.model.DAO.ProdutoDAO;
import br.ufsm.csi.model.DAO.VendaDAO;

public class redireciona_Logica implements Logica{

	@Override
	public String executa(HttpServletRequest request, HttpServletResponse response) {
		
		String direciona = request.getParameter("direciona");
		
		String pagina = "";
		
		if(direciona.equals("cadastrarProduto")){
			pagina = "/WEB-INF/JSP/cadastrarProduto.jsp";

			request.setAttribute("fornecedores", new FornecedorDAO().getFornecedores());
		}
		
		else if(direciona.equals("index"))
			pagina = "/index.jsp";
		
		else if(direciona.equals("venda")){
			pagina = "/WEB-INF/JSP/venda.jsp";
			
			try {
				request.setAttribute("clientes", new VendaDAO().getClientes());
				request.setAttribute("produtos", new ProdutoDAO().lista());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		else if(direciona.equals("consultarVenda")){
			pagina = "/WEB-INF/JSP/consultarVendas.jsp";
			
			try { request.setAttribute("vendas", new VendaDAO().getVendas()); } catch (Exception e) {}
		}
		
		else if(direciona.equals("modificarProduto")){
			pagina = "/WEB-INF/JSP/modificarProduto.jsp";
		
			request.setAttribute("produtos", new ProdutoDAO().lista());
		}
		
		else if(direciona.equals("alterar")){
			pagina = "/WEB-INF/JSP/alterarProduto.jsp";
			
			String id = request.getParameter("id");
			
			request.setAttribute("produto", new ProdutoDAO().getProduto(Integer.parseInt(id)));
			request.setAttribute("fornecedores", new FornecedorDAO().getFornecedores());
			request.setAttribute("produtoAlterar", id);
		}
		
		else if(direciona.equals("cadastrarFornecedor")){
			pagina = "/WEB-INF/JSP/cadastrarFornecedor.jsp";
			
			request.setAttribute("produtos", new ProdutoDAO().lista());
		}
		
		else if(direciona.equals("modificarFornecedor")){
			pagina = "/WEB-INF/JSP/modificarFornecedor.jsp";
		
			request.setAttribute("fornecedores", new FornecedorDAO().getFornecedores());
		}
		
		else if(direciona.equals("alterarFornecedor")){
			pagina = "/WEB-INF/JSP/alterarFornecedor.jsp";
			
			String id = request.getParameter("id");
			
			request.setAttribute("fornecedor", new FornecedorDAO().getFornecedor(Integer.parseInt(id)));
			request.setAttribute("produtos", new ProdutoDAO().lista());
			request.setAttribute("fornecedorAlterar", id);
		}
		
		return pagina;
	}

}

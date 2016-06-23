package br.ufsm.csi.controller.logica;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufsm.csi.model.ItemVenda;
import br.ufsm.csi.model.Produto;
import br.ufsm.csi.model.Venda;
import br.ufsm.csi.model.DAO.ProdutoDAO;
import br.ufsm.csi.model.DAO.VendaDAO;

public class itemVenda_Logica implements Logica{

	@Override
	public String executa(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setAttribute("clientes", new VendaDAO().getClientes());
			request.setAttribute("produtos", new ProdutoDAO().lista());
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		ArrayList<Produto> produtos = new ProdutoDAO().lista();
		
		ArrayList<ItemVenda> itemsprod = new ArrayList<ItemVenda>();
		
		for(int i=0; i < produtos.size(); i++){
			if(request.getParameter(Long.toString(produtos.get(i).getCodigo())) != null){
				ItemVenda iv = new ItemVenda();
				// os dados na tabele vem no formato codigo-quantidade
				String split[] = request.getParameter(Long.toString(produtos.get(i).getCodigo())).split("-");

				iv.setCodigo(produtos.get(i).getCodigo()); // posicao[0] = codigo
				iv.setQuantidade(Integer.parseInt(split[1]));  // posicao [1] = quantidade
				iv.setPrecoUnid(produtos.get(i).getPreco());
				float total = produtos.get(i).getPreco() * Integer.parseInt(split[1]);
				iv.setTotal(total);
				
				itemsprod.add(iv);
			}
			
		}
		
		Venda venda = new Venda();
		
		venda.setCliente(request.getParameter("cliente"));
		venda.setData(request.getParameter("data"));
		System.out.println(request.getParameter("data"));
		
		String pagina = "/WEB-INF/JSP/venda.jsp";
		
		try {
			boolean retorno = new VendaDAO().inserirItem(itemsprod, venda);
		
			if(retorno)			
				request.setAttribute("status", "vendaItem");
			else
				request.setAttribute("status", "erro_vendaItem");
			
		} catch (Exception e) {
			e.printStackTrace();
			
			return pagina;
		}

		return pagina;
	}

}

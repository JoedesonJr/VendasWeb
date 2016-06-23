package br.ufsm.csi.model.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import br.ufsm.csi.controller.logica.Logica;
import br.ufsm.csi.model.Cliente;
import br.ufsm.csi.model.Fornecedor;
import br.ufsm.csi.model.ItemVenda;
import br.ufsm.csi.model.Produto;
import br.ufsm.csi.model.Venda;

public class VendaDAO{

	private Connection conn = (Connection) ConectarPostGressFactory.getConexao();
	private PreparedStatement stmt;
	private boolean autenticado = false;
	private String sql;
	
	public ArrayList<Cliente> getClientes () throws Exception{
		
		ArrayList <Cliente> clientes = new ArrayList <Cliente>();
		
		try{	
			PreparedStatement stmt =  conn.prepareStatement("SELECT * FROM cliente;");
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				Cliente c = new Cliente();
				
				c.setCliente(rs.getInt("codigo"));
				c.setNome(rs.getString("nome"));
				
				clientes.add(c);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return clientes;
	}


	public boolean inserirItem(ArrayList<ItemVenda> itemsprod, Venda venda) throws Exception{
		
		sql = " BEGIN; " ;  // inicio transação
		
		sql += " INSERT INTO venda VALUES (default, "+venda.getCliente()+", '"+venda.getData()+"'); " ;
		
		for (int i=0; i < itemsprod.size(); i++) {  // inseri todos os fornecedor dos produtos na tabela n-n
			
			sql += " INSERT INTO item_venda "
					  + " (" + "SELECT currval(pg_get_serial_sequence('venda','codigo'))"+ "," 
					  		 + itemsprod.get(i).getCodigo()+ "," 
					  		 + itemsprod.get(i).getQuantidade()+ "," 
					  		 + itemsprod.get(i).getTotal()+ ") ; " 
			;
		}
		
		sql += " COMMIT; ";  // fecha transação
		
		stmt = conn.prepareStatement(sql);
		
		try{
			stmt.execute();
			
			autenticado = true;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return autenticado;
	}
	
	public ArrayList <Venda> getVendas () throws Exception{
			
		ArrayList <Venda> vendas = new ArrayList <Venda>();
			
			try{	
				PreparedStatement stmt =  conn.prepareStatement(
						" SELECT venda.codigo, nome, datavenda "
					  + " FROM venda, cliente "
					  + " WHERE venda.id_cliente = cliente.codigo ;"
				);
				
				ResultSet rs = stmt.executeQuery();
				
				while(rs.next()){
					Venda v = new Venda();
					
					v.setCodigo(rs.getInt("codigo"));
					v.setCliente(rs.getString("nome"));
					v.setData(rs.getString("datavenda"));
					v.setItemsVenda(getItems(v));
					
					vendas.add(v);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			
			return vendas;
	}
	
	public ArrayList<ItemVenda> getItems (Venda venda) throws Exception{
		
		ArrayList <ItemVenda> items = new ArrayList <ItemVenda>();

		try{
			sql = " SELECT descricao, qtd, preco, totalitem "
				+ " FROM item_venda, venda, produto "
				+ " WHERE item_venda.id_venda = venda.codigo "
				+ " AND item_venda.id_produto = produto.codigo "
				+ " AND id_venda= ? ;";
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, venda.getCodigo());
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				ItemVenda i = new ItemVenda();

				i.setDescricao(rs.getString("descricao"));
				i.setQuantidade(rs.getInt("qtd"));
				i.setPrecoUnid(rs.getFloat("preco"));
				i.setTotal(rs.getFloat("totalitem"));

				items.add(i);
			}
			}catch(Exception e){
			e.printStackTrace();
		}
		
		return items;
		}	
}

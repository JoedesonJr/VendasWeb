package br.ufsm.csi.model.DAO;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import br.ufsm.csi.model.Fornecedor;
import br.ufsm.csi.model.Produto;

public class ProdutoDAO {

	private Connection conn = (Connection) ConectarPostGressFactory.getConexao();
	private PreparedStatement stmt;
	private boolean autenticado = false;
	private String sql;
	
	public boolean inserir (Produto produto) throws Exception{
		// todos os fornecedores cadastrados
		ArrayList<Fornecedor> fornecedor = produto.getFornecedores();
		
		sql = " BEGIN; "  // inicio da transação
			+ " INSERT INTO produto VALUES (default, ?, ?); ";  // primeiro inseri na tabela produtos
		
		for (int i=0; i < fornecedor.size(); i++) {  // inseri todos os fornecedor dos produtos na tabela n-n
			
			sql = sql + " INSERT INTO fornecprod "
					  + " ( SELECT currval(pg_get_serial_sequence('produto','codigo')), " 
					  + fornecedor.get(i).getCodigo() +"); ";
		}
		
		sql = sql + " COMMIT; ";  // fecha transação
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, produto.getDescricao());
		stmt.setFloat(2, produto.getPreco());
		
		try{
			stmt.execute();
			
			autenticado = true;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return autenticado;
	}
	
	public boolean atualizar (Produto produto) throws Exception{
	
		sql = " BEGIN;"
			+ " DELETE FROM fornecprod WHERE codigoprod = ? ; " // deleta todos os registros do produto na tabela n-n
			+ " UPDATE produto SET descricao = ?, preco = ? WHERE codigo = ? ; " ; // atualiza a tabela produto

		for(int i=0; i < produto.getFornecedores().size(); i++){
			sql = sql + " INSERT INTO fornecprod VALUES (" +produto.getCodigo()+ "," +produto.getFornecedores().get(i).getCodigo()+ ") ; "; // inseri novamente os novos fornecedores na tabela n-n
		}
		
		sql = sql + " COMMIT; ";
		
		stmt = conn.prepareStatement(sql);
		
		stmt.setLong(1, produto.getCodigo());
		stmt.setString(2, produto.getDescricao());
		stmt.setFloat(3, produto.getPreco());
		stmt.setLong(4, produto.getCodigo());

		try{
			stmt.execute();

			autenticado = true;
		}catch(Exception e){
			e.printStackTrace();
		}

		return autenticado;
	}
	// todos os produtos com todos os seus fornecedores
	public ArrayList<Produto> lista (){
		
		ArrayList <Produto> produtos = new ArrayList <Produto>();
		
		try{	
			PreparedStatement stmt =  conn.prepareStatement("SELECT * FROM produto");
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				Produto p = new Produto();
				
				p.setCodigo(rs.getInt("codigo"));
				p.setDescricao(rs.getString("descricao"));
				p.setPreco(rs.getFloat("preco"));
				p.setFornecedores(getFornecedores(p));  // todos os fornecedores deste produto
				
				produtos.add(p);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return produtos;
	}
	
	public boolean remove (long id) throws Exception{
		
		// Apaga primeiro na tabela n-n e depois na tabela produto
		sql = "	BEGIN; "
			+ "	DELETE FROM fornecprod WHERE codigoprod = ? ; "
			+ " DELETE FROM item_venda WHERE id_produto = ? ;"
			+ " DELETE FROM produto WHERE codigo = ? ; "
			+ " COMMIT; ";
		
		stmt = conn.prepareStatement(sql);
		stmt.setLong(1, id);
		stmt.setLong(2, id);
		stmt.setLong(3, id);
		
		try{
			stmt.execute();
			
			autenticado = true;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return autenticado;
	}

	// retornar a lista de fornecedores vinculados ao produto
	public ArrayList<Fornecedor> getFornecedores (Produto produto){
		
		ArrayList <Fornecedor> fornecedores = new ArrayList <Fornecedor>();
		
		try{
			sql = " SELECT fornecedor.codigo, razaosocial "
				+ " FROM fornecedor, produto, fornecprod "
				+ " WHERE produto.codigo = fornecprod.codigoprod "
				+ " AND fornecedor.codigo = fornecprod.codigofornec "
				+ " AND produto.codigo = ? ;";
			
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, produto.getCodigo());
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				Fornecedor f = new Fornecedor();

				f.setCodigo(rs.getInt("codigo"));
				f.setRazaoSocial(rs.getString("razaosocial"));

				fornecedores.add(f);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return fornecedores;
	}
	// retorna um produto escolhido
	public Produto getProduto (int codigo){
		
		Produto p = new Produto();
		
		try{	
			PreparedStatement stmt =  conn.prepareStatement("SELECT * FROM produto WHERE produto.codigo = "+codigo+" ;");
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				p.setCodigo(rs.getInt("codigo"));
				p.setDescricao(rs.getString("descricao"));
				p.setPreco(rs.getFloat("preco"));
				p.setFornecedores(getFornecedores(p));  // todos os fornecedores deste produto
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return p;
	}
}

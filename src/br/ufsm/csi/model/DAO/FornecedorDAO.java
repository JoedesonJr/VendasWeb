package br.ufsm.csi.model.DAO;

import java.sql.PreparedStatement;
import java.util.ArrayList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import br.ufsm.csi.model.Fornecedor;
import br.ufsm.csi.model.Produto;

// Todos os fornecedores
public class FornecedorDAO {
	
	private Connection conn = (Connection) ConectarPostGressFactory.getConexao();
	private PreparedStatement stmt;
	private boolean autenticado = false;
	private String sql;
	
	public boolean inserir (Fornecedor f) throws Exception{
		// todos os fornecedores cadastrados
		ArrayList<Produto> produto = f.getProdutos();
				
		sql = " BEGIN; "  // inicio da transação
			+ " INSERT INTO fornecedor VALUES (default, ?); ";  // primeiro inseri na tabela produtos
				
				System.out.println("Codigo Fornecedor: " +f.getCodigo());
		
				for (int i=0; i < produto.size(); i++) {  // inseri todos os fornecedor dos produtos na tabela n-n
					System.out.println("Codigo Produto: " +produto.get(i).getCodigo());
					sql = sql + " INSERT INTO fornecprod "
							  + " SELECT produto.codigo, MAX(fornecedor.codigo) "
							  + " FROM produto, fornecedor " 
							  + " GROUP BY produto.codigo "
							  + " HAVING descricao = '"+ produto.get(i).getDescricao() +"' ; ";
				}
				
				sql = sql + " COMMIT; ";  // fecha transação
				
				stmt = conn.prepareStatement(sql);
				
				stmt.setString(1, f.getRazaoSocial());
				
				try{
					stmt.execute();
					
					autenticado = true;
				}catch(Exception e){
					e.printStackTrace();
				}
				
				return autenticado;
	}
	
	public boolean atualizar (Fornecedor fornecedor) throws Exception{
		
		sql = " BEGIN;"
				+ " DELETE FROM fornecprod WHERE codigofornec = ? ; " // deleta todos os registros do produto na tabela n-n
				+ " UPDATE fornecedor SET razaosocial = ? WHERE codigo = ? ; " ; // atualiza a tabela produto

			for(int i=0; i < fornecedor.getProdutos().size(); i++){
				sql = sql + " INSERT INTO fornecprod VALUES (" +fornecedor.getProdutos().get(i).getCodigo()+ "," +fornecedor.getCodigo()+ ") ; "; // inseri novamente os novos fornecedores na tabela n-n
			}
			
			sql = sql + " COMMIT; ";
			
			stmt = conn.prepareStatement(sql);
			
			stmt.setLong(1, fornecedor.getCodigo());
			stmt.setString(2, fornecedor.getRazaoSocial());
			stmt.setLong(3, fornecedor.getCodigo());

			try{
				stmt.execute();

				autenticado = true;
			}catch(Exception e){
				e.printStackTrace();
			}

			return autenticado;
	}
	
	public boolean remove (long id) throws Exception{
		
		// Apaga primeiro na tabela n-n e depois na tabela produto
		sql = "	BEGIN; "
			+ "	DELETE FROM fornecprod WHERE codigofornec = ? ; "
			+ " DELETE FROM fornecedor WHERE codigo = ? ; "
			+ " COMMIT; ";
				
		stmt = conn.prepareStatement(sql);
		stmt.setLong(1, id);
		stmt.setLong(2, id);
				
		try{
			stmt.execute();
					
			autenticado = true;
		}catch(Exception e){
			e.printStackTrace();
		}
				
		return autenticado;
	}
	// todos os produtos do fornecedor 
	public ArrayList<Produto> getProduto (Fornecedor fornecedor){
		
		ArrayList <Produto> produtos = new ArrayList <Produto>();
		
		try{
			sql = " SELECT produto.codigo, descricao, preco "
				+ " FROM fornecedor, produto, fornecprod "
				+ " WHERE produto.codigo = fornecprod.codigoprod "
				+ " AND fornecedor.codigo = fornecprod.codigofornec "
				+ " AND fornecedor.codigo = ? ;";
			
			stmt = conn.prepareStatement(sql);
			stmt.setLong(1, fornecedor.getCodigo());
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				Produto p = new Produto();

				p.setCodigo(rs.getInt("codigo"));
				p.setDescricao(rs.getString("descricao"));
				p.setPreco(rs.getFloat("preco"));

				produtos.add(p);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return produtos;
	}
	
	// retorna um fornecedor escolhido
	public Fornecedor getFornecedor (int codigo){
		
		Fornecedor f = new Fornecedor();
		
		try{	
			PreparedStatement stmt =  conn.prepareStatement("SELECT * FROM fornecedor WHERE fornecedor.codigo = "+codigo+" ;");
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				f.setCodigo(rs.getInt("codigo"));
				f.setRazaoSocial(rs.getString("razaoSocial"));
				f.setProdutos(getProduto(f));  // todos os fornecedores deste produto
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return f;
	}
	
	// Retorna todos os fornecedores com seus produtos
	public ArrayList <Fornecedor> getFornecedores(){
		
		ArrayList <Fornecedor> fornecedores = new ArrayList <Fornecedor>();
		
		try{	
			stmt =  conn.prepareStatement("SELECT * FROM fornecedor;");
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
				Fornecedor f = new Fornecedor();
				
				f.setCodigo(rs.getInt("codigo"));
				f.setRazaoSocial(rs.getString("razaosocial"));
				f.setProdutos(getProduto(f));
				
				fornecedores.add(f);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return fornecedores;
	}
	
}

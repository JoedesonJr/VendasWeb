package br.ufsm.csi.model;

public class ItemVenda {
	
	private int codigo;
	private String descricao;
	private int quantidade;
	private float precoUnid;
	private float total;
	
	
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	
	public float getPrecoUnid() {
		return precoUnid;
	}
	public void setPrecoUnid(float precoUnid) {
		this.precoUnid = precoUnid;
	}
	
	public float getTotal() {
		return total;
	}
	public void setTotal(float total) {
		this.total = total;
	}
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

}

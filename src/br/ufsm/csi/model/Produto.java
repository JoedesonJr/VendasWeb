package br.ufsm.csi.model;

import java.util.ArrayList;

public class Produto {
	
	private int codigo;
	private String descricao;
	private ArrayList<Fornecedor> fornecedores;
	private float preco;
	
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
	
	public ArrayList<Fornecedor> getFornecedores() {
		return fornecedores;
	}
	
	public void setFornecedores(ArrayList<Fornecedor> fornecedores) {
		this.fornecedores = fornecedores;
	}
	
	public float getPreco() {
		return preco;
	}
	
	public void setPreco(float preco) {
		this.preco = preco;
	}
}

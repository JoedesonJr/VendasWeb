package br.ufsm.csi.model;

import java.util.ArrayList;

public class Venda {

	private int codigo;
	private String cliente;
	private String data;
	private ArrayList<ItemVenda> itemsVenda;
	
	public String getCliente() {
		return cliente;
	}
	public void setCliente(String cliente) {
		this.cliente = cliente;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public ArrayList<ItemVenda> getItemsVenda() {
		return itemsVenda;
	}
	public void setItemsVenda(ArrayList<ItemVenda> itemsVenda) {
		this.itemsVenda = itemsVenda;
	}	
}

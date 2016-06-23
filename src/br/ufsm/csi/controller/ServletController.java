package br.ufsm.csi.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.ufsm.csi.controller.logica.Logica;

@WebServlet(name = "mvc", urlPatterns = { "/mvc" })
public class ServletController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ServletController() {
        super();
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("Entrou ServletController");
		
		String log = request.getParameter("logica");
		String classe = "br.ufsm.csi.controller.logica."+log;
		
		System.out.println("Valor de log: "+log);
		System.out.println("Vai carregar a classe: "+classe);
		
		try {
			Class classeCarregada = Class.forName(classe);

			Logica logica = (Logica) classeCarregada.newInstance();

			String fluxo = logica.executa(request, response);			
			request.getRequestDispatcher(fluxo)	.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
